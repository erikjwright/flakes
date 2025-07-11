{
  description = "Erik's flake monorepo with dev shells and templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    mcp-hub.url = "github:ravitemer/mcp-hub";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      imports = [
        ./modules/ts/module.nix
      ];

      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.git
              pkgs.direnv
              pkgs.nixfmt-rfc-style
            ];
          };
        };

      flake = {
        templates = {
          ts = {
            path = ./ts;
            description = "TS dev shell with bun, uv, git, nixfmt";
          };
        };
      };
    };
}
