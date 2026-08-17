{ config, pkgs, ... }:

{
  # GUI
  users.users."alvaro".packages = with pkgs; [
    kitty
    mpv
  ];

  # Terminal
  environment.systemPackages = with pkgs; [
    # Editors
    vim
    neovim
    lua5_1
    luarocks
    # CLI/TUI
    bat
    btop
    delta
    dysk
    eza
    fastfetch
    fd
    fzf
    hyperfine
    lazygit
    onefetch
    ripgrep
    samply
    starship
    tlrc
    typst
    zoxide
    # Python
    python313
    python313Packages.ipython
    python313Packages.pip
    uv
    # Utils
    gcc
    git
    nodejs
    stow
    unzip
    wget
    yt-dlp
  ];
}
