{ config, pkgs, lib, ... }:

let
  cfg = config.profiles.rust;
in
{
  options = {
    profiles.rust = {
      enable = lib.mkEnableOption "rust toolchain";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rust-bin.stable.latest.default
      cargo-nextest
      wasm-pack
    ];
  };
}
