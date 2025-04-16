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
          rootPath = ''$(root_dir=$(pwd); while [[ "$root_dir" != "/" ]]; do [[ -f "$root_dir/flake.nix" ]] && { echo "$root_dir"; exit 0; } || root_dir=$(dirname "$root_dir"); done; echo "flake.nix not found" >&2; exit 1)'';
        in
        {
          default = pkgs.mkShell {
            packages = [
              self.packages.x86_64-linux.default
              (pk "serve" ''lith serve --drafts'')
              (pk "serveh" # bash
                ''
                  wl-copy "http://192.168.10.7:3030/"
                  lith serve --drafts --host
                ''
              )
              (pk "build" ''lith build --no-minify'')
              (pk "new" ''lith new -k norg posts/$1'')
              (pk "edit" ''nvim ${rootPath}/Rattman/content/posts'')
              (pk "update" ''nix flake update'')
              (pk "deploy" # bash
                ''
                  cd ${rootPath}/Rattman
                  rm -r "${rootPath}/assets/"
                  rm -r "${rootPath}/categories"
                  rm -r "${rootPath}/posts"
                  rm "${rootPath}/index.html"
                  rm "${rootPath}/rss.xml"
                  rm -r "${rootPath}/Rattman/.build/"
                  # rm -r "${rootPath}/Rattman/content/.build/"
                  # rm -r "${rootPath}/Rattman/content/posts/.build/"
                  rm -r "${rootPath}/Rattman/public/"
                  build

                  cp -r ${rootPath}/Rattman/public/* ${rootPath}/
                ''
              )
              # (pk "work" # bash
              #   ''
              #     ghostty -e "hx ./templates/" &
              #     ghostty -e "nvim ./content/" &
              #     chromium "http://localhost:3030/" "https://ladas552.github.io/" &
              #     ghostty -e "${pkgs.links2}/bin/links "http://localhost:3030/"" &
              #     ghostty -e "lith serve -d ~/Projects/my_repos/ladas552.github.io/Rattman"
              #     niri msg action close-window
              #   ''
              # )
            ];
          };
        };
    };
}
