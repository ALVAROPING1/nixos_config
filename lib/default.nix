lib:
let
  inherit (builtins) readDir attrNames listToAttrs;
in
rec {
  # Discover NixOS configurations.
  # It will find all sub-directories in `hosts` and
  # include it if it has a configuration.nix.
  genNixOSHosts =
    { self, ... } @ args:
    let
      dir = "${self}/hosts";
      hosts = attrNames (readDir dir);

      mkHost = hostname:
        lib.nixosSystem ((removeAttrs args ["self"]) // {
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
      hosts);

  # Gets a list of all files within a folder recursively
  getFilesRecursive = dir: builtins.concatMap
    (e:
      let
        file = "${dir}/${e.name}";
      in
      if e.value == "directory" then (getFilesRecursive file) else [file])
    (lib.attrsToList (builtins.readDir dir));
}
