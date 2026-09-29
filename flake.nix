{
  description = "A walking-skeleton starter for Haskell JSON CLI tools";

  inputs = {
    # Latest (unstable) nix package set
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    # Utilities for dealing with multiple platforms
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils, ... }: 
    # Generate an output attrset for each supported system (aarch64-darwin, x86_64-darwin,
    # aarch64-linux, x86_64-linux)
    flake-utils.lib.eachDefaultSystem (system: 
      let
        # Evaluate the package set
        pkgs = import nixpkgs { inherit system; };
        # Expose standard nix library for reference
        inherit (pkgs) lib;
        # Use the GHC 9.12.3 stackage set. Note that ghc9124 currently won't build
        # haskell-language-server
        haskellPackages = pkgs.haskell.packages.ghc9123;
      in {
        # Output entire package set for convenience
        legacyPackages = pkgs;

        # Create a devShell with a hoogle database and other build tools
        devShells.default = haskellPackages.developPackage {
          root = ./.;

          # Build a Hoogle index. To start it, run: 
          # `nix develop -c hoogle server --local --port 8080`
          returnShellEnv = true;
          withHoogle = true;

          modifier = drv: 
            let
              hsBuildTools = with haskellPackages; [
                cabal-gild # Cabal source formatter
                cabal-install # Haskell build tool
                fourmolu # Haskell source formatter
                haskell-language-server # Haskell editor integration
                hlint # Haskell static analyzer
              ];

              otherBuildTools = with pkgs; [
                alejandra # Nix formatter
                just # Task runner
              ];

            in
              pkgs.haskell.lib.addBuildTools drv (hsBuildTools ++ otherBuildTools);
        };

        # Create a package that outputs the binary executable at ./result/bin/
        packages.default = haskellPackages.developPackage {
          root = ./.;
          returnShellEnv = false;
          withHoogle = false;
        };
      });
}
