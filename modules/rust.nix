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

  config = lib.mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      lib.optionals cfg.toolchain [
        rust-bin.stable.latest.default
        cargo-nextest
        wasm-pack
      ]
      ++ lib.optionals cfg.utils [
        bat
        delta
        dysk
        dua
        eza
        fd
        ripgrep
        zoxide
      ];
  };
}
