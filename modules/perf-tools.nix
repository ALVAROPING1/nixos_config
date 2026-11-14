{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.profiles.perf-tools;
in
{
  options = {
    profiles.perf-tools = {
      enable = lib.mkEnableOption "perf tools";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      perf
      samply
      hyperfine
    ];
  };
}
