{
  lib,
  pkgs,
  firefox-addons,
  ...
}: let
  inherit (lib) concatStringsSep escapeShellArg mapAttrsToList;
  env = {
    MOZ_WEBRENDER = 1;
    # For a better scrolling implementation and touch support.
    # Be sure to also disable "Use smooth scrolling" in about:preferences
    MOZ_USE_XINPUT2 = 1;
    # Required for hardware video decoding.
    # See https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
    MOZ_DISABLE_RDD_SANDBOX = 1;
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };
  envStr = concatStringsSep " " (mapAttrsToList (n: v: "${n}=${escapeShellArg v}") env);

  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "116.1";
    hash = "sha256-Ai8Szbrk/4FhGhS4r5gA2DqjALFRfQKo2a/TwWCIA6g=";
  };
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.overrideAttrs (old: {
      buildCommand =
        old.buildCommand
        + ''
          substituteInPlace $out/bin/firefox \
            --replace "exec -a" ${escapeShellArg envStr}" exec -a"
        '';
    });

    profiles.default = {
      id = 0;
      isDefault = true;

      extensions = with firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        tree-style-tab
        darkreader
        read-aloud
      ];

      # Hide tab bar because we have tree style tabs
      userChrome = ''
        #TabsToolbar {
          visibility: collapse !important;
        }

        #titlebar-buttonbox {
          height: 32px !important;
        }
      '';

      extraConfig = builtins.concatStringsSep "\n" [
        (builtins.readFile "${betterfox}/Securefox.js")
        (builtins.readFile "${betterfox}/Fastfox.js")
        (builtins.readFile "${betterfox}/Peskyfox.js")
      ];

      settings = {
        # General
        "intl.accept_languages" = "en-US,en";
        "browser.startup.page" = 3; # Resume previous session on startup
        "browser.aboutConfig.showWarning" = false; # I sometimes know what I'm doing
        "browser.ctrlTab.sortByRecentlyUsed" = false; # (default) Who wants that?
        "browser.download.useDownloadDir" = false; # Ask where to save stuff
        "browser.translations.neverTranslateLanguages" = "ko"; # No need :)
        "privacy.clearOnShutdown.history" = false; # We want to save history on exit
        # Hi-DPI
        "layout.css.devPixelsPerPx" = "1";
        # Allow executing JS in the dev console
        "devtools.chrome.enabled" = true;
        # Disable browser crash reporting
        "browser.tabs.crashReporting.sendReport" = false;
        # Allow userCrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # Why the fuck can my search window make bell sounds
        "accessibility.typeaheadfind.enablesound" = false;
        "general.autoScroll" = true;

        # Hardware acceleration
        # See https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "media.av1.enabled" = true; # Only enable with good GPU
        "media.ffvpx.enabled" = false;
        "media.rdd-vpx.enabled" = false;

        # Privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;

        "browser.send_pings" = false; # (default) Don't respect <a ping=...>

        # This allows firefox devs changing options for a small amount of users to test out stuff.
        # Not with me please ...
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;

        "beacon.enabled" = false; # No bluetooth location BS in my webbrowser please
        "device.sensors.enabled" = false; # This isn't a phone
        "geo.enabled" = false; # Disable geolocation alltogether

        # ESNI is deprecated ECH is recommended
        "network.dns.echconfig.enabled" = true;

        # Disable telemetry for privacy reasons
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.enabled" = false; # enforced by nixos
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.unified" = false;
        "extensions.webcompat-reporter.enabled" = false; # don't report compability problems to mozilla
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.urlbar.eventTelemetry.enabled" = false; # (default)

        # Disable some useless stuff
        "extensions.pocket.enabled" = false; # disable pocket, save links, send tabs
        "extensions.abuseReport.enabled" = false; # don't show 'report abuse' in extensions
        "extensions.formautofill.creditCards.enabled" = false; # don't auto-fill credit card information
        "identity.fxaccounts.enabled" = false; # disable firefox login
        "identity.fxaccounts.toolbar.enabled" = false;
        "identity.fxaccounts.pairing.enabled" = false;
        "identity.fxaccounts.commands.enabled" = false;
        "browser.contentblocking.report.lockwise.enabled" = false; # don't use firefox password manger
        "browser.uitour.enabled" = false; # no tutorial please
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # disable EME encrypted media extension (Providers can get DRM
        # through this if they include a decryption black-box program)
        "browser.eme.ui.enabled" = false;
        "media.eme.enabled" = false;

        # don't predict network requests
        "network.predictor.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;

        # disable annoying web features
        "dom.push.enabled" = false; # no notifications, really...
        "dom.push.connection.enabled" = false;
        "dom.battery.enabled" = false; # you don't need to see my battery...
        "dom.private-attribution.submission.enabled" = false; # No PPA for me pls
      };

      bookmarks = [
        {
          name = "Bookmarks Toolbar";
          toolbar = true;

          bookmarks = [
            {
              name = "Youtube";
              tags = ["youtube"];
              keyword = "youtube";
              url = "https://youtube.com/";
            }
            {
              name = "Perplexity";
              tags = ["perplexity"];
              keyword = "perplexity";
              url = "https://www.perplexity.ai/";
            }
            {
              name = "Scholar";
              tags = ["scholar"];
              keyword = "scholar";
              url = "https://scholar.google.com/";
            }
            {
              name = "HuggingFace";
              tags = ["huggingface"];
              keyword = "huggingface";
              url = "https://huggingface.co/";
            }
            {
              name = "Notion";
              tags = ["notion"];
              keyword = "notion";
              url = "https://www.notion.so/";
            }
            {
              name = "GPU Usage";
              tags = ["gpu"];
              keyword = "gpu";
              url = "https://docs.google.com/spreadsheets/d/1VDGNriWffX2h9_7jpaOQ_qDebGwBl6ydn-lZFrMRmP8/edit?pli=1&gid=0#gid=0";
            }
            {
              name = "NLP&AI NAS";
              tags = ["nas"];
              keyword = "nas";
              url = "https://163.152.71.163:5001/#/signin";
            }
            {
              name = "KU Portal";
              tags = ["ku"];
              keyword = "ku";
              url = "https://portal.korea.ac.kr/front/Main.kpd?language=ko";
            }
            {
              name = "KT";
              tags = ["kt"];
              keyword = "kt";
              url = "https://earth.kt.co.kr/";
            }
            {
              name = "NixOS & Flakes Book";
              tags = ["nix"];
              keyword = "nixos book";
              url = "https://nixos-and-flakes.thiscute.world/";
            }
            # {
            #   name = "NixOS Options";
            #   tags = ["nix"];
            #   keyword = "nixos options";
            #   url = "https://search.nixos.org/options";
            # }
            # {
            #   name = "NixOS Packages";
            #   tags = ["nix"];
            #   keyword = "nixos packages";
            #   url = "https://search.nixos.org/packages";
            # }
          ];
        }
      ];

      search = {
        force = true;
        default = "Google";
        order = ["Google" "Perplexity" "HuggingFace" "GitHub" "Youtube" "NixOS Options" "Nix Packages"];

        engines = {
          "Google" = {
            iconUpdateURL = "https://www.google.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@g"];
            urls = [
              {
                template = "https://www.google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Perplexity" = {
            iconUpdateURL = "https://www.perplexity.ai/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@ppl"];
            urls = [
              {
                template = "https://www.perplexity.ai/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Hugging Face Models" = {
            iconUpdateURL = "https://huggingface.co/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@hf"];
            urls = [
              {
                template = "https://huggingface.co/models";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "YouTube" = {
            iconUpdateURL = "https://youtube.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@yt"];
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "GitHub" = {
            iconUpdateURL = "https://github.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@gh"];

            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Nix Packages" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "NixOS Options" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Home Manager" = {
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@hm"];

            url = [
              {
                template = "https://mipmip.github.io/home-manager-option-search/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
