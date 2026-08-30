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
    nixosConfigurations = (import ./lib).genNixOSHosts {
      inherit inputs;
      specialArgs = { inherit inputs; flake_path = "/home/alvaro/nixos"; };
      modules = [
        ./modules
        ({ ... }: { nixpkgs.overlays = [ rust-overlay.overlays.default ]; })
      ];
    };
  };
}
