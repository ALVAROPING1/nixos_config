{ config, pkgs, ... }:

{
  # GUI
  users.users."alvaro".packages = with pkgs; [
    gimp
    inkscape
    keepassxc
    kitty
    libreoffice-qt
    mpv
    # onlyoffice-desktopeditors
    vesktop
  ];
  programs.firefox.enable = true;
  programs.obs-studio.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Terminal
  environment.systemPackages = with pkgs; [
    # Editors
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
    ffmpeg
    fzf
    htop
    lazygit
    onefetch
    pandoc
    ripgrep
    starship
    tlrc
    typst
    zoxide
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
