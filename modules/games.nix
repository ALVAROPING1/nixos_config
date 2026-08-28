{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  users.users."alvaro".packages = with pkgs; [
    goverlay
  ];
}
