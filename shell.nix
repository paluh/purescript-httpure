
let
  version = "v0.1.0";
  nixjs = fetchTarball "https://github.com/cprussin/nixjs/tarball/release-19.03";
  pkgs = import <nixpkgs> {
    overlays = [ (import nixjs { purescript = "0.12.5"; spago = "0.7.5.0"; }) ];
  };
in

pkgs.mkShell {
  buildInputs = [
    pkgs.purescript
    pkgs.git
    pkgs.nodejs
    pkgs.nodePackages.jshint
    pkgs.nodePackages.bower
    pkgs.yarn
    pkgs.psc-package
  ];
  shellHook = "export PATH=$PATH:$PWD/node_modules/.bin";
}
