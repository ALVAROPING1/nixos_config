{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    lua5_1
    luarocks
    nodejs # Required by some LSPs
  ];
}
