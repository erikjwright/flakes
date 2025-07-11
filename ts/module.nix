{ inputs, pkgs, ... }:
let
  mcp = inputs.mcp-hub.packages.${pkgs.system}.default;
in
{
  perSystem =
    {
      system,
      pkgs,
      mcp,
      ...
    }:
    {
      devShells.dev-template = pkgs.mkShell {
        name = "modo-dev";
        buildInputs = [
          mcp
          pkgs.biome
          pkgs.bun
          pkgs.nixfmt-rfc-style
          pkgs.nodejs_24
          pkgs.tailwindcss-language-server
          pkgs.typescript-language-server
          pkgs.uv
        ];
        # shellHook = ''echo "🚀 TS dev shell ready!"'';
      };
    };
}
