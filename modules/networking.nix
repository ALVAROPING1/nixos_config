{ pkgs, ... }:

{
  networking = {
    # TODO: try using only dhcpcd on hosts with a single ethernet port
    # use networkmanager
    networkmanager = {
      enable = true;
      plugins = with pkgs; [ ];
    };
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # `dhcpcd` conflicts with NetworkManager's `dhclient`, as they try to bind
    # the same address; it needs to be explicitly disabled.
    dhcpcd.enable = false;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };

  # Configure the OpenSSH daemon
  services.openssh.settings = {
    PasswordAuthentication = false;
    KbdInteractiveAuthentication = false;
    PermitRootLogin = "no";
  };

  services.resolved.enable = true;

  users.users."alvaro".extraGroups = [ "networkmanager" ];
}
