{
  description = "Rayed BQN Template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bqnlsp.url = "sourcehut:~detegr/bqnlsp";
    rayed-bqn.url = "github:DavidZwitser/rayed-bqn";
  };

  outputs = { self, nixpkgs, flake-utils, bqnlsp, rayed-bqn}:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      bqnlspPkg = bqnlsp.packages.${system}.lsp;

      cbqn = pkgs.cbqn-replxx;
      raylib = pkgs.raylib;
    in rec {

      packages.default = pkgs.writeShellScriptBin "run" /*bash*/ ''
        # Setting up rayed-bqn and its submodules
        git submodule update --init --recursive

        # Editing the config to use Nix paths
        echo "raylibheaderpath ⇐ •file.At \"${raylib}/include/raylib.h\"" > "./rayed-bqn/config.bqn"
        echo "rayliblibpath ⇐ •file.At \"${raylib}/lib/libraylib.dylib\"" >> "./rayed-bqn/config.bqn"

        # Running the program
     	  ${cbqn}/bin/bqn -f ./src/main.bqn
      '';

      devShells.default = pkgs.mkShell {
        buildInputs = [
          cbqn
          bqnlspPkg
        ];
      };
  });
}
