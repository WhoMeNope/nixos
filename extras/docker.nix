{ config, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
}
