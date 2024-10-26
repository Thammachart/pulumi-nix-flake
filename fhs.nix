{ pkgs, pulumi-cli, ... }:
pkgs.buildFHSEnv {
  name = "pulumi-fhs";
  targetPkgs = pkgs: (with pkgs; [
    pulumi-cli
    coreutils nushell nodejs curl
  ]);

  profile = ''
    export FHS=1;
  '';
  # runScript = "nu";
}
