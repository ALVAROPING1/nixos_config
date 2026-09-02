{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.livesplit-one-druid;
in
{
  options = {
    programs.livesplit-one-druid = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether to add livesplit-one-druid to the global environment and
          configure a setcap wrapper for it.
        '';
      };

      package = lib.mkPackageOption pkgs "livesplit-one-druid" { };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    security.wrappers.livesplit-one-druid-packet = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_ptrace+eip";
      source = "${cfg.package}/bin/livesplit-one";
    };
  };
}
