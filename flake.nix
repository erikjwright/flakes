{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      with pkgs;
      {
        devShells = {
          default = mkShell {
            buildInputs = [
              nix
              nixfmt-rfc-style
            ];
          };
          bun = mkShell {
            buildInputs = [
              bun
            ];
          };
        };
      }
    );
}
