{
  lib,
  stdenv,
  appimageTools,
  fetchurl,
}:

appimageTools.wrapType2 rec {
  pname = "rewind";
  version = "0.2.2";

  src =
    {
      x86_64-linux = fetchurl {
        url = "https://github.com/abstrakt8/${pname}/releases/download/v${version}/Rewind-${version}.AppImage";
        hash = "sha256-2SfrmP/Y3JrQeYn06vvjKRUrHb2p0SqSB7w18/ybbeg=";
      };
    }
    .${stdenv.system} or (throw "${pname}: ${stdenv.system} is unsupported.");

  extraInstallCommands =
    let
      contents = appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun --no-sandbox' 'Exec=${pname}' \
        --replace 'Icon=${pname}' 'Icon=${pname}.png'
      echo "Comment=${meta.description}" >> $out/share/applications/${pname}.desktop
      install -D ${contents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    '';

  meta = {
    description = "Beatmap/replay analyzer for the rhythm game called osu!";
    license = lib.licenses.mit;
    homepage = "https://github.com/abstrakt8/${pname}";
    changelog = "https://github.com/abstrakt8/${pname}/releases/tag/v${version}";
  };
}
