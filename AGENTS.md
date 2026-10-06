# Agent Instructions

## Testing

 - Add or update Hspec tests when changing behavior.
 - Base expected results on requirements and examples, not the implementation itself.
 - After making any code or build-configuration changes, run `just fmt` and `just check`.
   Report failures or skipped checks.
 - Run `just` and `cabal` tasks inside the `nix develop` shell

## Conventions

 - Preserve architcture and conventions. Ask before performing consequential refactors or
   adding dependencies.

## Boundaries

 - Do not edit files unless explicitly asked.
 - Work in bounded vertical slices.
 - Do not create Git commits.
