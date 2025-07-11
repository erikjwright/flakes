{
  description = "Dev shell with bun, MCP Hub, and language tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mcp-hub.url = "github:ravitemer/mcp-hub";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      mcp-hub,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        mcp = mcp-hub.packages.${system}.default;
      in
      {
        devShells.default = pkgs.mkShell {
          name = "modo-dev";
          buildInputs = [
            pkgs.biome
            pkgs.bun
            mcp
            pkgs.nixfmt-rfc-style
            pkgs.nodejs_24
            pkgs.tailwindcss-language-server
            pkgs.typescript-language-server
            pkgs.uv
          ];
        };
      }
    );
}
