# Show available recipes
default:
    @just --list --unsorted

# Build the executable
build:
    cabal build all

# Run the executable (`just run -- --help`)
run *args:
    cabal run "json-demo:exe:json-demo" -- {{ args }}

# Run the test suite
test:
    cabal test all

# Build the nix package
dist:
    nix build .\#

# Run static analyzers and formatter checks
check:
    hlint .
    fourmolu --mode check app src test
    cabal-gild --mode check --input json-demo.cabal
    alejandra --check flake.nix
    just test

# Run formatters
fmt:
  fourmolu --mode inplace app src test
  cabal-gild --mode format --io json-demo.cabal
  alejandra flake.nix

# Run a local hoogle server
hoogle:
    hoogle server --local --port 8000
