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
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.texliveBasic.withPackages (
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
    ] ++ lib.optional cfg.pandoc pkgs.pandoc;
  };
}
