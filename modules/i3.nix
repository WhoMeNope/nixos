{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    enableCtrlAltBackspace = true;

    layout = config.console.keyMap;          # Use same keyMap as console
    xkbOptions = "eurosign:e, ctrl:nocaps";  # CapsLock is Ctrl

    # Enable touchpad support.
    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
    };
    synaptics.enable = false;

    # Desktop
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        tinybeachthor.i3status-rust
        i3lock-color

        xss-lock        # x sesssion locker
        xclip           # x clipboards
        maim            # screenshots
        conky           # i3status-rust cpu stats
        iw              # i3status-rust wireless strength
        font-awesome_4  # i3status-rust icon font
      ];
      package = pkgs.i3-gaps;
    };
    displayManager.defaultSession = "none+i3";
  };

  services.upower.enable = true;  # i3status-rust battery stats

  environment.systemPackages = with pkgs; [
    xorg.xhost  # manage access to x sesssion (e.g. allow access from docker)
  ];
}
