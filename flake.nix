{
  description = "Erik's flake monorepo — imports subflakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ts.url = "path:./ts";
  };

  outputs =
    { self, ts, ... }:
    {
      ts = ts;
    };
}
