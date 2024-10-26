{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {};
      systems = ["x86_64-linux"];
      perSystem = { config, pkgs, stdenv, ... }: {
        packages.default = pkgs.callPackage ./package.nix {};
        devShells.default = import ./fhs { inherit config pkgs stdenv; };
      };
    };
}