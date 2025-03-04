{
  description = "A very basic flake";

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
    }@inputs:
    {

      packages.x86_64-linux.default = norgolith.packages.x86_64-linux.default;

    };
}
