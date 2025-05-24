{
  description = "Open corresponding 'Fallen London Wiki' page with one click!";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        fl-oneclick-wiki = pkgs.callPackage ./package.nix {};
      in {
        packages = {
          inherit fl-oneclick-wiki;
          default = fl-oneclick-wiki;
        };
        devShells.default = pkgs.mkShell {
          packages = builtins.attrValues {inherit (pkgs) web-ext;};
        };
      }
    );
}
