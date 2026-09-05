{ config, pkgs, lib, ... }:

let
  cfg = config.profiles.games;
in
{
  options = {
    profiles.games = {
      enable = lib.mkEnableOption "games profile";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
    programs.livesplit-one-druid.enable = true;
    users.users."alvaro".packages = with pkgs; [
      goverlay
    ];
  };
}
