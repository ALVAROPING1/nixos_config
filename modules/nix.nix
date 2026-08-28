{ pkgs, flake_path, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Enable flake support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable nix helpter and garbage collection
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = flake_path; # sets NH_OS_FLAKE variable for you
  };

  # Allow unpatched dynamic libraries for generic distros
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [];
  };
}
