{ lib, stdenv, fetchurl }:
let
  metadata = builtins.fromJSON ./metadata.json;
in
stdenv.mkDerivation {
  pname = "pulumi-cli-unwrapped";
  inherit (metadata) version;

  src = fetchurl metadata.${stdenv.hostPlatform.system};

  installPhase = ''
    install -D -t $out/bin/ *
  '';

  # nativeBuildInputs = [];
  # buildInputs = [ stdenv.cc.cc.libgcc or null ];

  meta = with lib; {
    homepage = "https://pulumi.io/";
    description = "Pulumi CLI (unwrapped)";
  };
}