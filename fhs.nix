{ pkgs, stdenv, ... }:
pkgs.buildFHSEnv {
  targetPkgs = pkgs: (with pkgs; [
    curl wget stdenv.cc
  ]);
}