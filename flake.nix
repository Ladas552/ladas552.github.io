{
  description = "Shell with norgolith";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
          pk = pkgs.writeShellScriptBin;
        in
        {
          default = pkgs.mkShell {
            packages = [
              self.packages.x86_64-linux.default
              (pk "serve" ''lith dev --drafts'')
              (pk "serveh" # bash
                ''
                  wl-copy "http://$(ip route get 1 | awk '{print $7}'):3030"
                  lith serve --drafts --host
                ''
              )
              (pk "build" ''lith build -m'')
              (pk "new" ''lith new -k norg posts/$1'')
              (pk "edit" ''nvim ./content/posts'')
              (pk "update" ''nix flake update'')
            ];
          };
        };
    };
}
