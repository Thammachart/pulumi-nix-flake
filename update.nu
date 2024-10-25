let systems = [
  { os: "linux", arch: "x64", archNix: "x86_64" }
];

def createUrl [version: string, os: string, arch: string] {
  $"https://get.pulumi.com/releases/sdk/pulumi-v($version)-($os)-($arch).tar.gz"
}

def getChecksum [version: string] {
  http get $"https://get.pulumi.com/releases/sdk/pulumi-($version)-checksums.txt" | from ssv --noheaders --aligned-columns | rename sha256 file
}

def sha256sum [checksum: table, url: string] {
  $checksum | where file == ($url | path basename) | get sha256 | first
}

def generateMetadata [rec: record] {
  $rec | to json
}

def main [version: string] {
  let checksum = getChecksum $version;

  mut nixos = {};
  for sys in $systems {
    let url = createUrl $version $sys.os $sys.arch;
    let sha256 = sha256sum $checksum $url;
    $nixos = $nixos | insert $"($sys.archNix)-($sys.os)" { url: $url, sha256: $sha256 };
  }
  generateMetadata { version: $version, systems: $nixos } | save --force metadata.json;
}
