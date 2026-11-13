{ config, pkgs, lib, ... }:

let
  cfg = config.profiles.desktop.kde;
in
{
  options = {
    profiles.desktop.kde = {
      enable = lib.mkEnableOption "KDE profile";
    };
  };

  config = lib.mkIf cfg.enable {
    profiles.desktop.enable = true;
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [ elisa qrca ];

    users.users."alvaro".packages = with pkgs; [
      # Apps
      kdePackages.ark
      kdePackages.discover
      kdePackages.dolphin
      kdePackages.gwenview
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kfind
      kdePackages.kate # Bundles kwrite
      kdePackages.okular
      kdePackages.spectacle
      kronometer
      # Themes
      kdePackages.breeze-gtk
      kdePackages.breeze-icons
      kdePackages.breeze.qt5
      kdePackages.breeze
      kdePackages.krohnkite
      kde-rounded-corners
    ];
    programs.partition-manager.enable = true;
  };
}
