# Show available recipes
default:
    @just --list --unsorted

# Build the executable
build:
    cabal build all

# Run the executable (`just run -- --help`)
run *args:
    cabal run "haskell-json-cli-starter:exe:haskell-json-cli-starter" -- {{ args }}

# Run the test suite
test:
    cabal test all

# Build the nix package
dist:
    nix build .\#

# Run the static analyzers (hlint)
lint:
    hlint .
