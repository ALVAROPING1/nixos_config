{ config, pkgs, ... }:

{
  # Terminal
  environment.systemPackages = with pkgs; [
    # CLI/TUI
    btop
    fastfetch
    ffmpeg
    fzf
    htop
    lazygit
    onefetch
    starship
    tlrc
    typst
    # Python
    (python3.withPackages (ps: [ ps.ipython ]))
    uv
    # Utils
    borgbackup
    gcc
    gnumake
    imagemagick
    nodejs
    stow
    xclip
    yt-dlp
    # Nix
    deadnix
    nixd
    # nixfmt-rs
    statix
  ];

  # Shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  programs.nix-index.enable = true;
}
