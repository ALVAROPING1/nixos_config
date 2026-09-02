{ rustPlatform
, fetchFromGitHub
, pkg-config
, wrapGAppsHook3
}:

rustPlatform.buildRustPackage rec {
  pname = "livesplit-one-druid";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "AlexKnauth";
    repo = pname;
    tag = version;
    hash = "sha256-VNxiwlYpTVC1hC5r+zHGWQ7C/mS6juvPDEU4p5jvRas=";
  };

  cargoHash = "sha256-Veb61MtyJNH0fKodphHwfkXRjIW7vIzOJBPH9CfEIak=";

  # wrapGAppsHook3 fixes GTK-3 errors
  nativeBuildInputs = [ pkg-config wrapGAppsHook3 ];

  meta = {
    description = "Prototype Desktop version of LiveSplit One";
    homepage = "https://github.com/AlexKnauth/${pname}";
    changelog = "https://github.com/AlexKnauth/${pname}/releases/tag/${version}";
    mainProgram = "livesplit-one";
  };
}
