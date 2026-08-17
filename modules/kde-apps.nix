{ config, pkgs, ... }:

{
  users.users."alvaro".packages = with pkgs; [
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
  ];
  programs.partition-manager.enable = true;
}
