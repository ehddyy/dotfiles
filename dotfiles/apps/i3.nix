{ config, lib, pkgs, ... }:

let 
  mod = "Mod1";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      terminal = "konsole";
      
      fonts = {
        names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
        style = "Bold Semi-Condensed";
        size = 11.0;
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";

        # Focus
        "${mod}+j" = "focus up";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus right";
        "${mod}+h" = "focus left";

        "${mod}+!" = "workspace next";
        "${mod}+:" = "workspace previous";

        # Move
        "${mod}+Shift+j" = "move up";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+h" = "move left";

        "${mod}+n" = "split horizontal";
        "${mod}+b" = "split vertical";

      };
      assigns = {
        "3: web" = [{ class = "^Firefox$"; }];
        };
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
        }
      ];
    };
  };
}