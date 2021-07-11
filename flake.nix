{
  inputs = {
    flake-utils.url = github:numtide/flake-utils/master;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
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
  outputs = {
    self,
    flake-utils,
    nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager,
    tinybeachthor, remarkable
  }: rec {
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
            ./modules/wacom.nix
            ./modules/crosscompile-aarch64-linux.nix

            home-manager.nixosModules.home-manager
            ./users
            ./environment.nix

            ({
              hardware.spacenavd.enable = true;

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
        GUILTYSPARK = nixpkgs-unstable.lib.nixosSystem rec {
          system = "aarch64-linux";
          modules = [
            # nixos-hardware.nixosModules.raspberry-pi-4
            ({ config, lib, pkgs, modulesPath, ... }: {
              imports = [
                ./modules/sd-image-aarch64.nix
                # (modulesPath + "/profiles/headless.nix")
                # (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
              ];

              boot.kernelPackages = pkgs.linuxPackages_latest;

              # boot.loader.raspberryPi.enable = true;
              # boot.loader.raspberryPi.version = 4;

              sdImage = {
                compressImage = false;
                # imageBaseName = lib.mkDefault config.networking.hostName;
              };
            })
            # ({ lib, ... }: {
            #   powerManagement.cpuFreqGovernor = "ondemand";

            #   users.users.chief = {
            #     isNormalUser = true;
            #     home = "/home/chief";
            #     createHome = true;
            #     extraGroups = [
            #       "wheel"
            #     ];
            #     openssh.authorizedKeys.keys = [
            #       (builtins.readFile (./. + "/secret/chief@GUILTYSPARK.pub"))
            #     ];
            #   };
            #   security.sudo.wheelNeedsPassword = false;

            #   # OpenSSH is forced to have an empty `wantedBy` on the installer system[1], this won't allow it
            #   # to be automatically started. Override it with the normal value.
            #   # [1] https://github.com/NixOS/nixpkgs/blob/9e5aa25/nixos/modules/profiles/installation-device.nix#L76
            #   systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];
            #   # Enable OpenSSH out of the box.
            #   services.sshd.enable = true;

              # networking.hostName = "GUILTYSPARK";
            #   time.timeZone = "America/Los_Angeles";
            #   system.stateVersion = "21.05";
            # })
          ];
        };
      };
    sdImages = {
      GUILTYSPARK = nixosConfigurations.GUILTYSPARK.config.system.build.sdImage;
    };
  };
}
