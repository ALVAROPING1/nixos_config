{ config, pkgs, lib, ... }:

let
  cfg = config.profiles.games;
in
{
  options = {
    profiles.games = {
      enable = lib.mkEnableOption "games profile";
      osu = lib.mkEnableOption "osu!";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.steam = {
        enable = true;
        package = pkgs.steam.override {
          extraEnv = {
            MANGOHUD = true;
            OBS_VKCAPTURE = true;
          };
        };
      };
      programs.livesplit-one-druid.enable = true;
      users.users."alvaro".packages = with pkgs; [
        goverlay
      ];

      programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
        input-overlay
        obs-vkcapture
      ];
    }

    (lib.mkIf cfg.osu {
      users.users."alvaro".packages = [ pkgs.osu-lazer-bin ];
      hardware.opentabletdriver.enable = true;
    })
  ]);
}
