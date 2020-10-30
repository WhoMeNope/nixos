{ pkgs, ... }:

{
  nix.trustedUsers = [ "root" "martin" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    martin = {
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "audio"
        "jackaudio"
        "video"
        "vboxusers"
      ];

      home = "/home/martin";
      createHome = true;

      isNormalUser = true;
      uid = 1000;
    };
  };
  home-manager.users = {
    martin = { pkgs, ... }:
    {
      imports = [ ];

      xresources.properties = import ./martin/xresources.nix;

      programs = {
        neovim = import ./martin/neovim.nix { inherit pkgs; };
        gh = {
          enable = true;
          gitProtocol = "ssh";
        };
        alacritty = import ./martin/alacritty.nix { inherit pkgs; };
      };

      home.packages = with pkgs; [
        firefox
        xfce.thunar
        xfce.ristretto
        spotify

        libreoffice
        pdftk
        xournal
        vlc

        slack

        gimp
        inkscape
        blender

        shotwell
        rawtherapee
        shotcut
      ];
    };
  };
  home-manager.useGlobalPkgs = true;
}