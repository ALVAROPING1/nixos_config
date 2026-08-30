let
  inherit (builtins) readDir attrNames listToAttrs;

  loadHosts = dir: attrNames (readDir dir);
in
{
  # Discover NixOS configurations.
  # It will find all sub-directories in `hosts` and
  # include it if it has a configuration.nix.
  genNixOSHosts =
    { inputs, ... } @ args:
    let
      dir = "${inputs.self}/hosts";

      mkHost = hostname:
        inputs.nixpkgs.lib.nixosSystem ((removeAttrs args ["inputs"]) // {
          modules = [
            "${dir}/${hostname}/configuration.nix"
            "${dir}/${hostname}/hardware-configuration.nix"
            ({ ... }: { networking.hostName = hostname; })
          ] ++ args.modules;
        });
    in
    listToAttrs (map
      (name: {
        inherit name;
        value = mkHost name;
      })
      (loadHosts dir));
}
