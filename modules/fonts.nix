{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;

    enableGhostscriptFonts = true;

    fonts = with pkgs; [
      corefonts
      terminus_font
      corefonts           # Microsoft free fonts
      inconsolata         # monospaced
      ubuntu_font_family  # Ubuntu fonts
      unifont             # some international languages
      font-awesome-ttf
      hack-font
      noto-fonts
      powerline-fonts
    ];
  };
}
