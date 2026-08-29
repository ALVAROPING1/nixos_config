{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    (texliveBasic.withPackages (ps: with ps; [
      latexmk
      biber
      biblatex-ieee
      collection-latexextra
      collection-plaingeneric
      collection-luatex
      collection-mathscience
      collection-langspanish
    ]))
  ];
}
