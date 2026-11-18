_final: prev: {
  livesplit-one-druid = prev.callPackage ./livesplit-one-druid.nix { };
  colortune = prev.callPackage ./colortune.nix { };
}
