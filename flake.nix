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
        in
        {
          default = pkgs.mkShell {
            packages = [
              self.packages.x86_64-linux.default
              (pkgs.writeShellScriptBin "ser" ''lith serve --drafts'')
              (pkgs.writeShellScriptBin "serd" ''lith serve --no-drafts'')
              (pkgs.writeShellScriptBin "build" ''lith build -m'')
              (pkgs.writeShellScriptBin "new" ''lith new -k norg posts/$1'')
              (pkgs.writeShellScriptBin "update" ''nix flake update'')
              (pkgs.writeShellScriptBin "work" # bash
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
