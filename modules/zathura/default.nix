{
  config,
  pkgs,
  color-palette,
  ...
}: {
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
    options = {
      window-title-basename = "true";
      selection-clipboard = "clipboard";
      notification-error-bg = "${color-palette.nord11}";
      notification-error-fg = "${color-palette.nord4}";
      notification-warning-bg = "${color-palette.nord12}";
      notification-warning-fg = "${color-palette.nord6}";
      notification-bg = "${color-palette.nord0}";
      notification-fg = "${color-palette.nord4}";
      completion-bg = "${color-palette.nord0}";
      completion-fg = "${color-palette.nord1}";
      completion-group-bg = "${color-palette.nord0}";
      completion-group-fg = "${color-palette.nord1}";
      completion-highlight-bg = "${color-palette.nord3}";
      completion-highlight-fg = "${color-palette.nord4}";
      index-bg = "${color-palette.nord0}";
      index-fg = "${color-palette.nord4}";
      index-active-bg = "${color-palette.nord3}";
      index-active-fg = "${color-palette.nord4}";
      inputbar-bg = "${color-palette.nord0}";
      inputbar-fg = "${color-palette.nord4}";
      statusbar-bg = "${color-palette.nord0}";
      statusbar-fg = "${color-palette.nord4}";
      highlight-color = "${color-palette.nord12}";
      highlight-active-color = "${color-palette.nord15}";
      default-bg = "${color-palette.nord0}";
      default-fg = "${color-palette.nord4}";
      render-loading = true;
      render-loading-fg = "${color-palette.nord0}";
      render-loading-bg = "${color-palette.nord4}";
      recolor-lightcolor = "${color-palette.nord0}";
      recolor-darkcolor = "${color-palette.nord4}";
      adjust-open = "width";
      # recolor = true;
    };
  };
}
