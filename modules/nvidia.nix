{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  ...
}:

let
  cfg = config.profiles.nvidia;
in
{
  options = {
    profiles.nvidia = {
      enable = lib.mkEnableOption "nvidia driver profile";
    };
  };
  config = lib.mkIf cfg.enable {
    # Enable nvidia driver
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = true;
    # nvidia driver doesn't built on stable's latest kernel
    boot.kernelPackages = lib.mkForce pkgs-unstable.linuxPackages_latest;

    # Enable hardware acceleration (NVEnc)
    programs.obs-studio.package = pkgs.obs-studio.override { cudaSupport = true; };
  };
}
