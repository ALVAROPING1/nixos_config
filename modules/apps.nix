{ config, pkgs, flake_path, ... }:

{
  # GUI
  users.users."alvaro".packages = with pkgs; [
    gimp
    inkscape
    keepassxc
    kitty
    libreoffice-qt
    mpv
    obs-studio
    # onlyoffice-desktopeditors
    vesktop
  ];
  programs.firefox.enable = true;

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
    htop
    hyperfine
    lazygit
    # nvtopPackages.full
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
    imagemagick
    nodejs
    stow
    unzip
    wget
    yt-dlp
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = flake_path; # sets NH_OS_FLAKE variable for you
  };

  # Shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
}
