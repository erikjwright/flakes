{
  description = "Erik's flake monorepo with dev shells and templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    mcp-hub.url = "github:ravitemer/mcp-hub";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.outputs.mkFlake {
      inherit inputs;

      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      imports = [
        ./modules/ts/module.nix
      ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.nixfmt-rfc-style
              pkgs.git
              pkgs.direnv
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
