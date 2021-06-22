{
  inputs = {
    flake-utils.url = github:numtide/flake-utils/master;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;
    home-manager = {
      url = github:rycee/home-manager/release-21.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tinybeachthor = {
      url = github:tinybeachthor/nur-packages/master;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    remarkable = {
      url = github:tinybeachthor/remarkable/master;
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        tinybeachthor.follows = "tinybeachthor";
      };
    };
  };
  outputs = { self, flake-utils, nixpkgs, home-manager, tinybeachthor, remarkable }:
  {
    nixosConfigurations.ALBATROSS = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ({
          nixpkgs = {
            overlays = [
              tinybeachthor.overlay
              remarkable.overlay.${system}
            ];
            config = { allowUnfree = true; allowBroken = false; };
          };
          nix.registry.nixpkgs.flake = nixpkgs;

          # https://github.com/NixOS/nix/issues/3821
          systemd.services.nix-daemon.serviceConfig.LimitSTACKSoft = "infinity";

          networking.hostName = "ALBATROSS";
        })
        ./hardware-configuration.nix
        ./cachix.nix

        ./profiles/desktop.nix

        ./extras/intel.nix
        ./extras/thinkpad.nix
        ./extras/wacom.nix

        home-manager.nixosModules.home-manager
        ./users
        ./environment.nix

        ({
          # Set your time zone.
          time.timeZone = "America/Los_Angeles";
          # time.timeZone = "Europe/Amsterdam";

          # This value determines the NixOS release with which your system is to be
          # compatible, in order to avoid breaking some software such as database
          # servers. You should change this only after NixOS release notes say you
          # should.
          system.stateVersion = "19.09"; # Did you read the comment?
        })
      ];
    };
  };
}
