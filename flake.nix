{
  description = "Erik's flake monorepo — imports subflakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, ... }:
    {
      ts = builtins.getFlake (toString ./ts);
    };
}
