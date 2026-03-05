{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    {
      packages = forAllSystems (system: {
        default = self.packages.${system}.itgmania-export-favorites;
        itgmania-export-favorites = nixpkgs.legacyPackages.${system}.callPackage (
          { runCommand }:
          runCommand "itgmania-export-favorites" { } ''
                      install -Dm755 ${./itgmania-export-favorites.sh} $out/bin/itgmania-export-favorites
            	''
        ) { };
      });
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
