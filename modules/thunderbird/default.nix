{
  pkgs,
  color-palette,
  ...
}: {
  programs.thunderbird = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
        settings = {
          # General UI colors
          "browser.display.background_color" = "${color-palette.nord0}";
          "browser.display.foreground_color" = "${color-palette.nord4}";
          "browser.display.use_system_colors" = false;

          # Link colors
          "browser.anchor_color" = "${color-palette.nord8}";
          "browser.active_color" = "${color-palette.nord7}";
          "browser.visited_color" = "${color-palette.nord15}";

          # Compose window colors
          "msgcompose.background_color" = "${color-palette.nord0}";
          "msgcompose.text_color" = "${color-palette.nord4}";
          "msgcompose.default_colors" = false;

          # Mail citation color
          "mail.citation_color" = "${color-palette.nord9}";

          # Label colors
          "mailnews.labels.color.1" = "${color-palette.nord11}";
          "mailnews.labels.color.2" = "${color-palette.nord12}";
          "mailnews.labels.color.3" = "${color-palette.nord14}";
          "mailnews.labels.color.4" = "${color-palette.nord9}";
          "mailnews.labels.color.5" = "${color-palette.nord15}";

          # Tag colors (matching labels)
          "mailnews.tags.$label1.color" = "${color-palette.nord11}";
          "mailnews.tags.$label2.color" = "${color-palette.nord12}";
          "mailnews.tags.$label3.color" = "${color-palette.nord14}";
          "mailnews.tags.$label4.color" = "${color-palette.nord9}";
          "mailnews.tags.$label5.color" = "${color-palette.nord15}";

          # Reader mode
          "reader.color_scheme" = "dark";
        };
      };
    };
  };
}
