{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay, ... } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; flake_path = "/home/alvaro/nixos"; };
      modules = [
        ./configuration.nix
        ./modules
        ({ ... }: { nixpkgs.overlays = [ rust-overlay.overlays.default ]; })
      ];
    };
  };
}
