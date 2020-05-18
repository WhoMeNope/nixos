# My NixOS

## Repo structure

```
/
  .config/         # Non-nix config files
    ...

  pkgs/            # Custom & overridden pkgs
    overrides.nix  # Exports all pkgs
    ...

  modules/         # Standalone tidbits
    ...

  profiles/        # Full system configs
    base.nix
    ...

  cachix/
  cachix.nix
  hardware-configuration.nix
  configuration.nix
```