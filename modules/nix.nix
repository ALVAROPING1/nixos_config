{ pkgs, flake_path, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      # Enable flake support
      experimental-features = [ "nix-command" "flakes" ];
      # Extra binary caches
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    optimise.automatic = true;
  };

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
