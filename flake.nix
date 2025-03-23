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
              (pk "serve" ''lith serve --drafts'')
              (pk "served" ''lith serve --no-drafts'')
              (pk "build" ''lith build -m'')
              (pk "new" ''lith new -k norg posts/$1'')
              (pk "update" ''nix flake update'')
              (pk "work" # bash
                ''
                  ghostty -e "hx ./templates/" &
                  ghostty -e "nvim ./content/" &
                  chromium "http://localhost:3030/" "https://ladas552.github.io/" &
                  ghostty -e "${pkgs.links2}/bin/links "http://localhost:3030/"" &
                  ghostty -e "lith serve -d ~/Projects/my_repos/ladas552.github.io/Rattman"
                  niri msg action close-window
                ''
              )
            ];
          };
        };
    };
}
