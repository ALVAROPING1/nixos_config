{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
    let
      lib = import ./lib nixpkgs.lib;
      overlays = [
        inputs.rust-overlay.overlays.default
        (import ./pkgs/overlay.nix)
      ];
    in
    {
      nixosConfigurations = lib.genNixOSHosts {
        inherit self;
        specialArgs = { inherit inputs; flake_path = "/home/alvaro/nixos"; };
        modules = lib.getFilesRecursive ./modules ++ [
          ({ ... }: { nixpkgs = { inherit overlays; }; })
          inputs.nix-index-database.nixosModules.default
        ];
      };
    };
}
