{ config, inputs, lib, pkgs, ... }:
let
  textfox-src = pkgs.fetchFromGitHub {
    owner = "adriankarlen";
    repo = "textfox";
    rev = "main"; # Ou un commit spécifique pour plus de stabilité
    sha256 = "sha256-17mjdwa3vs2iqqn2a6ihvnayv23qihbis40rgaxc8v11z9y8bmmb";
  };
in
{
  programs.firefox = {
    enable = true;
    /* ---- POLICIES ---- */
    # Check about:policies#documentation for options.
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
    };
    profiles.default = {
      isDefault = true;
      path = "nix-profile";

      userContent = ''
       @import "${textfox-src}/userContent.css";
      '';
      # Cf this conf: https://github.com/vimjoyer/nix-firefox-video
      # Check extensions name here
      # https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/addons.json?ref_type=heads
      # extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
      extensions.packages = with inputs.firefox-addons.packages."aarch64-darwin"; [
        bitwarden
        vimium
        adblocker-ultimate
        tree-style-tab
        ublock-origin
        # pocket
      ];
      settings = {
        "layers.acceleration.force-enabled" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.color-mix.enabled" = true;

        # Disable all sorts of telemetry
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # As well as Firefox 'experiments'
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "network.allow-experiments" = false;

        # privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;

        # Enable HTTPS-Only Mode
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;

        # Fastfox: https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js
        "content.notify.interval" = 100000;

        # General
        # From https://github.com/oddlama/nix-config/blob/main/users/myuser/graphical/firefox.nix
        "browser.startup.page" = 3; # Resume previous session on startup
        "browser.download.useDownloadDir" = false; # Ask where to save stuff
        # Disable browser crash reporting
        "browser.tabs.crashReporting.sendReport" = false;
        # Allow userCrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # Why the fuck can my search window make bell sounds
        "accessibility.typeaheadfind.enablesound" = false;
        # If nvidia
        # Hardware acceleration 
        # See https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
        # "gfx.webrender.all" = true;
        # "media.ffmpeg.vaapi.enabled" = true;
        # "media.rdd-ffmpeg.enabled" = true;
        # "widget.dmabuf.force-enabled" = true;
        # "media.av1.enabled" = false; # XXX: change once I've upgraded my GPU

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
        "extensions.abuseReport.enabled" = false; # don't show 'report abuse' in extensions
        "extensions.formautofill.creditCards.enabled" = false; # don't auto-fill credit card information
        "browser.contentblocking.report.lockwise.enabled" = false; # don't use firefox password manger
        "browser.uitour.enabled" = false; # no tutorial please
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # Textfox
        "browser.tabs.drawInTitlebar" = true;
        "browser.tabs.inTitlebar" = 1;

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
      userChrome = ''
        # Import Textfox
        @import "${textfox-src}/userChrome.css";

        /* Tes personnalisations pour Tree Style Tab restent ici */
        #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar>.toolbar-items {
          opacity: 0;
          pointer-events: none;
        }
        #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
          visibility: collapse !important;
        }
        #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
          display: none;
        }
      '';
    };
  };
  home.file."Library/Application Support/Firefox/Profiles/nix-profile/chrome/assets".source = "${textfox-src}/assets";

}
