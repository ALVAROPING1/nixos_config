{ config, lib, ... }:

let
  cfg = config.profiles.vm;
in
{
  options = {
    profiles.vm = {
      enable = lib.mkEnableOption "vm profile";
    };
  };
  
  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;
    users.users."alvaro".extraGroups = [ "libvirtd" ];
    virtualisation.libvirtd.enable = true;
  };
}
