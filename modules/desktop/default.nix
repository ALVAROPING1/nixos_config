{ config, pkgs, ... }:

{
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];

    # Configure keymap in X11
    xkb = {
      layout = "es";
      variant = "nodeadkeys";
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # GUI Apps
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
}
