{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.profiles.rust;
in
{
  options = {
    profiles.rust = {
      enable = lib.mkEnableOption "rust profile";
      toolchain = lib.mkEnableOption "toolchain";
      utils = lib.mkEnableOption "rusty utils";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf cfg.toolchain {
        environment.systemPackages = with pkgs; [
          rust-bin.stable.latest.default
          cargo-nextest
          wasm-pack
        ];
      })
      (lib.mkIf cfg.utils {
        environment.systemPackages = with pkgs; [
          bat
          delta
          dysk
          eza
          fd
          ripgrep
          zoxide
        ];
      })
    ]
  );
}
