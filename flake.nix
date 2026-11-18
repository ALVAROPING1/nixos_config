{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      lib = import ./lib nixpkgs.lib;
      overlays = [
        inputs.rust-overlay.overlays.default
        (import ./pkgs/overlay.nix)
      ];
      flake_path = "/home/alvaro/nixos";
    in
    {
      nixosConfigurations = lib.genNixOSHosts {
        inherit self;
        specialArgs = { inherit inputs flake_path; };
        modules = lib.getFilesRecursive ./modules ++ [
          { nixpkgs = { inherit overlays; }; }
          (
            # Add pkgs-unstable arg to all modules, copying config from pkgs
            { pkgs, ... }:
            {
              _module.args = {
                pkgs-unstable = import inputs.nixpkgs-unstable {
                  system = pkgs.stdenv.hostPlatform.system;
                  config.allowUnfree = pkgs.config.allowUnfree;
                };
              };
            }
          )
          inputs.nix-index-database.nixosModules.default
        ];
      };
    };
}
