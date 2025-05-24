{
  stdenv,
  lib,
  web-ext,
}: let
  version = "1.9.2";
in
  stdenv.mkDerivation {
    pname = "fl-oneclick-wiki";
    inherit version;
    src = lib.cleanSource ./.;
    patches = ./nix.patch;
    nativeBuildInputs = [web-ext];
    # NIX_DEBUG = 6;
    buildPhase =
      # bash
      ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        export HOME=$(mktemp -d)
        web-ext build --no-input --verbose --artifacts-dir="$dst" --ignore-files=manifest_v3.json screen*.png
      '';
  }
