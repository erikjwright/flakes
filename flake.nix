{
  description = "Erik's flake monorepo with flake-parts and modular dev shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
    mcp-hub.url = "github:ravitemer/mcp-hub";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];

      imports = [
        ./ts/module.nix
      ];

      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.git
              pkgs.nixfmt-rfc-style
              pkgs.direnv
            ];
          };
        };

      flake = {
        templates.ts = {
          path = ./ts;
          description = "TS dev shell template with bun, uv, git, nixfmt";
        };
      };
    };
}
