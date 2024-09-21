{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrains Mono";
      font_size = 12;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      background_opacity = "0.95";
      window_padding_width = 5;
    };
    extraConfig = ''
      # Add any additional configuration here
    '';
  };
}

