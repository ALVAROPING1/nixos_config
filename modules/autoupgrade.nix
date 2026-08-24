{ config, pkgs, flake_path, ... }:

{
  system.autoUpgrade = {
    enable = false;
    flags = [
      "--update-input" "nixpkgs" # Update nixpkgs
      "--commit-lock-file" # Create a commit in the repo
      "--print-build-logs"
    ];
    flake = flake_path;
    upgrade = false; # Upgrade is unnecessary for flakes, and creates a warning
    persistent = true;
  };

  # Allow root user to access the flake directory
  systemd.tmpfiles.settings."10-root-gitconfig" = {
    "/root/.gitconfig"."f+" = {
      user = "root";
      group = "root";
      mode = "700";
      argument = "[safe]\n  directory = ${flake_path}\n";
    };
  };

  # Add git name/email variables for the commit
  systemd.services.nixos-upgrade.environment =
    let
      name = "NixOS Auto-Upgrade";
      email = "root@${config.networking.hostName}";
    in {
      GIT_AUTHOR_NAME = name;
      GIT_AUTHOR_EMAIL = email;
      GIT_COMMITTER_NAME = name;
      GIT_COMMITTER_EMAIL = email;
    };
}
