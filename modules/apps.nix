{ config, pkgs, ... }:

{
  # Terminal
  environment.systemPackages = with pkgs; [
    # CLI/TUI
    btop
    fastfetch
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
    gcc
    gnumake
    imagemagick
    nodejs
    stow
    xclip
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
