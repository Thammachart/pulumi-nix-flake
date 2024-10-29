{ lib, stdenv, fetchurl, ... }:
let
  metadata = lib.importJSON ./metadata.json;
in
stdenv.mkDerivation {
  pname = "pulumi-cli-unwrapped";
  inherit (metadata) version;

  src = fetchurl metadata.systems.${stdenv.hostPlatform.system};

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    install -D -t $out/bin/ *
  '';

  meta = with lib; {
    homepage = "https://pulumi.io/";
    description = "Pulumi CLI (unwrapped)";
  };
}
