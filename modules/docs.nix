{ config, pkgs, ... }:

{
  documentation = {
    # install documentation from all packages `environment.systemPackages`
    enable = true;

    doc.enable = true; # enable documentation distributed in packages' `/share/doc`
    dev.enable = true; # enable packages' developer documentation
    nixos.enable = true; # install nixos' own documentation

    man = {
      enable = true;
      # generate manpage index caches to enable searching using `man -k`
      cache.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];
}
