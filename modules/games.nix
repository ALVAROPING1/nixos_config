{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  programs.livesplit-one-druid.enable = true;
  users.users."alvaro".packages = with pkgs; [
    goverlay
  ];
}
