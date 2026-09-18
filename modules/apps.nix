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
    # yubioath-flutter
  ];
  programs.firefox.enable = true;
  programs.obs-studio.enable = true;
  programs.yubikey-manager.enable = true;
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
    python313
    python313Packages.ipython
    python313Packages.pip
    uv
    # Utils
    borgbackup
    gcc
    gnumake
    imagemagick
    nodejs
    rust-bin.stable.latest.default
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
