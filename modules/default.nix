{ pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./desktop
    ./apps.nix
    ./fonts.nix
    ./docs.nix
    ./networking.nix
    ./autoupgrade.nix
    ./games.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties
  console.keyMap = "es"; # Configure console keymap
  i18n =
    let locale = "es_ES.UTF-8";
    in {
      defaultLocale = locale;
      extraLocaleSettings = {
        LC_ADDRESS = locale;
        LC_IDENTIFICATION = locale;
        LC_MEASUREMENT = locale;
        LC_MONETARY = locale;
        LC_NAME = locale;
        LC_NUMERIC = locale;
        LC_PAPER = locale;
        LC_TELEPHONE = locale;
        LC_TIME = locale;
      };
    };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    unzip
    time
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;
  users.users."alvaro" = {
    isNormalUser = true;
    description = "Alvaro";
    extraGroups = [ "wheel" ]; # Enable `sudo` for the user
    initialPassword = "changethis";
  };
}
