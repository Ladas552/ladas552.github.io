{
  description = "Shell with norgolith";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    norgolith.url = "github:NTBBloodbath/norgolith";
  };

  outputs =
    {
      self,
      nixpkgs,
      norgolith,
      ...
    }:
    {

      packages.x86_64-linux.default = norgolith.packages.x86_64-linux.default;
      devShells.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        {
          default = pkgs.mkShell {
            packages = [ self.packages.x86_64-linux.default ];
          };
        };
    };
}
