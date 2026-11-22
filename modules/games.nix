{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.profiles.games;
in
{
  options = {
    profiles.games = {
      enable = lib.mkEnableOption "games profile";
      osu = lib.mkEnableOption "osu!";
      livesplit = lib.mkEnableOption "livesplit";
      recording = lib.mkEnableOption "obs recording";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
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
        programs.livesplit-one-druid.enable = cfg.livesplit;
        users.users."alvaro".packages = with pkgs; [
          goverlay
        ];
      }

      (lib.mkIf cfg.recording {
        programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
          input-overlay
          obs-vkcapture
        ];
      })

      (lib.mkIf cfg.osu {
        users.users."alvaro".packages = [ (pkgs.osu-lazer-bin.override { nativeWayland = true; }) ];
        hardware.opentabletdriver.enable = true;
        environment.systemPackages = lib.optional config.profiles.desktop.kde.enable pkgs.colortune;
        # Fix for OTD crashing on boot
        # TODO: remove on the next version of NixOS
        # SEE: https://github.com/NixOS/nixpkgs/pull/543033
        systemd.user.services.opentabletdriver = {
          unitConfig = {
            After = "graphical-session.target";
            ConditionEnvironment = [
              "|WAYLAND_DISPLAY"
              "|DISPLAY"
            ];
          };
          serviceConfig.ExecStartPre = lib.mkForce (pkgs.writeShellScript "poll-for-non-gdm-greeter-display" ''
            if [[ "$USER" = "gdm-greeter"* \
                || ( "$${XDG_SESSION_TYPE}" = wayland && -z "$${WAYLAND_DISPLAY}" ) ]]; then
              exit 1
            fi
          '');
        };
      })
    ]
  );
}
