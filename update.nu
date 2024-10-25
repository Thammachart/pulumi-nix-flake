let systems = [
  { os: "linux", arch: "x64", archNix: "x86_64" }
];

def createUrl [version: string, os: string, arch: string] {
  $"https://get.pulumi.com/releases/sdk/pulumi-v($version)-($os)-($arch).tar.gz"
}

def sha256sum [url: string] {
  http get $url | hash sha256
}

def generateMetadata [rec: record] {
  $rec | to json
}

def main [version: string] {
  mut nixos = {};
  for sys in $systems {
    let url = createUrl $version $sys.os $sys.arch;
    let sha256 = sha256sum $url;
    $nixos = $nixos | insert $"($sys.archNix)-($sys.os)" { url: $url, sha256: $sha256 };
  }
  generateMetadata { version: $version, systems: $nixos } | save --force metadata.json;
}
