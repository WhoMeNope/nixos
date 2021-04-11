{ pkgs, ... }:

{
  # Install the flakes edition
  nix.package = pkgs.nixFlakes;
  # Enable the nix 2.0 CLI and flakes support feature-flags
  # Garbage collect if disk full
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    min-free = ${toString (100 * 1024 * 1024)}
    max-free = ${toString (1024 * 1024 * 1024)}
  '';

  # Binary caches
  nix.binaryCachePublicKeys = [
  "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];
  nix.binaryCaches = [
    "https://hydra.iohk.io"
  ];

  # Garbage collect old generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # AutoOptimiseStore
  nix.autoOptimiseStore = true;
}
