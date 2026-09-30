# Show available recipes
default:
    @just --list --unsorted

# Build the executable
build:
    cabal build all

# Run the executable (`just run -- --help`)
run *args:
    cabal run "haskell-json-cli-starter:exe:starter" -- {{ args }}

# Run the test suite
test:
    cabal test all

# Build the nix package
dist:
    nix build .\#

# Run the static analyzers (hlint)
lint:
    hlint .

# Run a local hoogle server
hoogle:
    hoogle server --local --port 8000
