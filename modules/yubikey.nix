{ config, lib, ... }:

let
  cfg = config.profiles.yubikey;
in
{
  options = {
    profiles.yubikey = {
      enable = lib.mkEnableOption "yubikey profile";
      touch-notify = lib.mkEnableOption "touch request notifications" // {
        default = true;
      };
      management = lib.mkEnableOption "management of yubikeys";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.yubikey-manager.enable = cfg.management;
    programs.yubikey-touch-detector.enable = cfg.touch-notify;

    # users.users."alvaro".packages = with pkgs; [
    #   yubioath-flutter
    # ];
  };
}
