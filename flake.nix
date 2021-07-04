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
    nixosConfigurations =
      let
        common = {
          modules = [
            ({
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = false;
              };

              nix.registry.nixpkgs.flake = nixpkgs;
            })
          ];
        };
      in {
        ALBATROSS = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = common.modules ++ [
            ./hardware/lenovo-l380-yoga.nix
            ./cachix.nix

            ./profiles/desktop.nix
            ./extras/wacom.nix
            ./extras/crosscompile-aarch64-linux.nix

            home-manager.nixosModules.home-manager
            ./users
            ./environment.nix

            ({
              nixpkgs.overlays = [
                tinybeachthor.overlay
                remarkable.overlay.${system}
              ];

              networking.hostName = "ALBATROSS";

              # time.timeZone = "Europe/Amsterdam";
              time.timeZone = "America/Los_Angeles";

              # This value determines the NixOS release with which your system is to be
              # compatible, in order to avoid breaking some software such as database
              # servers. You should change this only after NixOS release notes say you
              # should.
              system.stateVersion = "19.09"; # Did you read the comment?
            })
          ];
        };
        GUILTYSPARK = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          modules = common.modules ++ [
            ({ modulesPath, ... }: {
              imports = [
                (modulesPath + "/installer/sd-card/sd-image-aarch64-new-kernel.nix")
              ];
            })
            ({
              powerManagement.cpuFreqGovernor = "ondemand";

              users.users.chief = {
                isNormalUser = true;
                home = "/home/chief";
                createHome = true;
                extraGroups = [
                  "wheel"
                ];
                openssh.authorizedKeys.keys = [
                ];
              };
              security.sudo.wheelNeedsPassword = false;
              services.openssh.enable = true;

              networking.hostName = "GUILTYSPARK";
              time.timeZone = "America/Los_Angeles";
              system.stateVersion = "21.05";
            })
          ];
        };
      };
  };
}
