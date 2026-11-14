{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.profiles.latex;
in
{
  options = {
    profiles.latex = {
      enable = lib.mkEnableOption "latex profile";
      pandoc = lib.mkEnableOption "pandoc";
    };
  };
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        environment.systemPackages = with pkgs; [
          (texliveBasic.withPackages (
            ps: with ps; [
              latexmk
              biber
              biblatex-ieee
              collection-latexextra
              collection-plaingeneric
              collection-luatex
              collection-mathscience
              collection-langspanish
            ]
          ))
        ];
      }
      (lib.mkIf cfg.pandoc { environment.systemPackages = [ pkgs.pandoc ]; })
    ]
  );
}
