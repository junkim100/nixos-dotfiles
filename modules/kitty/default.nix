{
  pkgs,
  color-palette,
  ...
}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font = {
      name = "FiraCode Nerd Font";
      size = 14;
    };
    settings = {
      shell = "${pkgs.zsh}/bin/zsh";
      adjust_line_height = 0;
      adjust_column_width = -1;
      disable_ligatures = "never";
      cursor = "${color-palette.nord4}";
      cursor_text_color = "background";
      cursor_beam_thickness = 1;
      cursor_blink_interval = 0;
      url_color = "${color-palette.nord10}";
      url_style = "straight";
      open_url_with = "default";
      detect_urls = true;
      copy_on_select = true;
      strip_trailing_spaces = "smart";
      input_delay = 3;
      sync_to_monitor = true;
      enable_audio_bell = false;
      visual_bell_duration = 0;
      window_border_width = 1;
      draw_minimal_borders = true;
      window_margin_width = 0;
      single_window_margin_width = -1;
      window_padding_width = 0;
      placement_strategy = "center";
      active_border_color = "${color-palette.nord14}";
      inactive_border_color = "${color-palette.nord4}";
      inactive_text_alpha = "0.8";
      hide_window_decorations = true;
      confirm_os_window_close = 0;
      tab_bar_edge = "top";
      tab_bar_margin_width = 1;
      tab_bar_margin_height = "0.0 10.0";
      tab_bar_style = "powerline";
      tab_bar_align = "left";
      tab_bar_min_tabs = 2;
      tab_powerline_style = "angled";
      tab_activity_symbol = "none";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";
      active_tab_foreground = "${color-palette.nord3}";
      active_tab_background = "${color-palette.nord9}";
      active_tab_font_style = "bold";
      inactive_tab_foreground = "${color-palette.nord4}";
      inactive_tab_background = "${color-palette.nord1}";
      inactive_tab_font_style = "normal";
      foreground = "${color-palette.nord6}";
      background = "${color-palette.nord0}";
      background_opacity = "0.9";
      selection_background = "${color-palette.nord5}";
      color0 = "${color-palette.nord0}";
      color1 = "${color-palette.nord11}";
      color2 = "${color-palette.nord14}";
      color3 = "${color-palette.nord13}";
      color4 = "${color-palette.nord10}";
      color5 = "${color-palette.nord15}";
      color6 = "${color-palette.nord7}";
      color7 = "${color-palette.nord6}";
      clipboard_control = "write-clipboard write-primary read-clipboard-ask read-primary-ask";
      allow_hyperlinks = "ask";
      shell_integration = "enabled";
      tabs = true;
    };
    keybindings = {
      "ctrl+tab+1" = "goto_tab 1";
      "ctrl+tab+2" = "goto_tab 2";
      "mod+k" = "clear_terminal clear active";
      "kitty_mod" = "ctrl+shift";
      "kitty_mod+q" = "close_tab";
      "kitty_mod+t" = "new_tab";
      "kitty_mod+tab" = "previous_tab";
      "ctrl+tab" = "next_tab";
      "kitty_mod+v" = "paste_from_clipboard";
      "kitty_mod+c" = "copy_to_clipboard";
    };
  };
}
