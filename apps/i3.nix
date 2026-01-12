{ config, lib, pkgs, ... }:

let 
  mod = "Mod1";
  lowbattery-alert = pkgs.callPackage ./lowbattery-alert.nix {};
  wallpaper-roller = pkgs.callPackage ./wallpaper-roller.nix {};
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";

      terminal = "konsole";

      fonts = {
        names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
        style = "Bold Semi-Condensed";
        size = 11.0;
      };

      menu = "dmenu";

      keybindings = lib.mkOptionDefault {
        "Mod4+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "Mod4+x" = "exec sh -c '${pkgs.maim}/bin/maim --select | xclip -selection clipboard -t image/png'";
        "Mod4+Shift+x" = "exec sh -c '/usr/bin/i3lock -c 222222 & sleep 5 && xset dpms force off'";  # Need sudo apt install i3lock

        "Mod4+Shift+s" = "exec sh -c 'gnome-control-center'";
        # "Mod4+Shift+o" = "exec sh -c 'xrandr --output eDP-1 --auto'";
        "Mod4+q" = "kill";
        "Mod4+a" = "exec sh -c 'nemo'";
        "Mod4+u" = "exec sh -c 'firefox -new-tab \"https://calendar.google.com/calendar/u/0/r/week\"'; workspace 1: Web";
        "Mod4+Shift+u" = "exec sh -c 'firefox -new-tab \"https://mail.google.com/\"'; workspace 1: Web";

        # dmenu
        "Mod4+d" = "exec rofi -no-config -no-lazy-grab -show drun -modi drun -show-icons -theme DarkBlue";
        # "Mod4+d" = "exec dmenu_run";

        # Focus
        "Mod4+j" = "focus up";
        "Mod4+k" = "focus down";
        "Mod4+l" = "focus right";
        "Mod4+h" = "focus left";

        "Mod4+!" = "workspace next";
        "Mod4+:" = "workspace previous";

        # Move
        "Mod4+Shift+j" = "move up";
        "Mod4+Shift+k" = "move down";
        "Mod4+Shift+l" = "move right";
        "Mod4+Shift+h" = "move left";

        "Mod4+n" = "split horizontal";
        "Mod4+b" = "split vertical";

        # Workspace
        "Mod4+1" = "workspace 1: Web";
        "Mod4+2" = "workspace 2: Terminal";
        "Mod4+3" = "workspace 3: Terminal";
        "Mod4+4" = "workspace 4: Code";
        "Mod4+5" = "workspace 5: Code";
        "Mod4+6" = "workspace 6: Code";
        "Mod4+7" = "workspace 7: Doc";
        "Mod4+8" = "workspace 8";
        "Mod4+9" = "workspace 9";
        "Mod4+0" = "workspace 0: Chat";

        # Navigating workspace
        "Mod4+Shift+Right" =  "workspace next";
        "Mod4+Shift+Left" =  "workspace prev";

        "Mod4+Shift+1" = "move container to workspace 1: Web; workspace 1: Web";
        "Mod4+Shift+2" = "move container to workspace 2: Terminal; workspace 2: Terminal";
        "Mod4+Shift+3" = "move container to workspace 3: Terminal; workspace 3: Terminal";
        "Mod4+Shift+4" = "move container to workspace 4: Code; workspace 4: Code";
        "Mod4+Shift+5" = "move container to workspace 5: Code; workspace 5: Code";
        "Mod4+Shift+6" = "move container to workspace 6: Code; workspace 6: Code";
        "Mod4+Shift+7" = "move container to workspace 7: Doc; workspace 7: Doc";
        "Mod4+Shift+8" = "move container to workspace 8; workspace 8";
        "Mod4+Shift+9" = "move container to workspace 9; workspace 9";
        "Mod4+Shift+0" = "move container to workspace 0: Chat; workspace 0: Chat";


        "Mod1+r" = "mode 'resize'";
        
        # Workspaces
        "Mod4+c" = "move workspace to output primary";
        "Mod4+v" = "move workspace to output nonprimary";
        "Mod4+m" = "mode 'monitor'";
        "Mod4+o" = "exec sh -c 'xrandr --output eDP-1 --auto --output DP-1-1 --auto --right-of DP-1-3'";


        "Mod4+Shift+space" = "floating toggle";

      };
      modes = {
        resize = {
          # These bindings trigger as soon as you enter the resize mode
          # Pressing left will shrink the window’s width.
          # Pressing right will grow the window’s width.
          # Pressing up will shrink the window’s height.
          # Pressing down will grow the window’s height
          j = "resize shrink width 10 px or 10 ppt";
          k = "resize grow height 10 px or 10 ppt";
          l = "resize shrink height 10 px or 10 ppt";
          semicolon = "resize grow width 10 px or 10 ppt";

          # same bindings, but for the arrow keys
          Left = "resize shrink width 10 px or 10 ppt";
          Down = "resize grow height 10 px or 10 ppt";
          Up = "resize shrink height 10 px or 10 ppt";
          Right = "resize grow width 10 px or 10 ppt";

          # back to normal: Enter or Escape or $mod+r
          Return = "mode default";
          Escape = "mode default";
        };
        monitor = {
          # These bindings trigger as soon as you enter the monitor mode
          # Pressing left will shrink the window’s width.
          # Pressing right will grow the window’s width.
          # Pressing up will shrink the window’s height.
          # Pressing down will grow the window’s height
          h = "move workspace to output left";
          Left = "move workspace to output left";
          M = "move workspace to output right";
          Right = "move workspace to output right";

          # back to normal: Enter or Escape or $mod+r
          Return = "mode default";
          Escape = "mode default";
        };
      };
      assigns = {
        "1: Web" = [{ class = "^Firefox$"; }];
        # "1: Web" = [{ class = "^Google Chrome$"; }];
        "7: Doc" = [{ class = "^Sublime Text$"; }];
        "0: Chat" = [{ class = "^Slack$"; }];
      };
      bars = [
        {
          position = "top";
          # statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}";
          # statusCommand = "$HOME/.config/home-manager/apps/i3bar/mybar.sh";
          statusCommand = "i3blocks -c $HOME/.config/i3blocks/config";
          fonts = {
            names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
            style = "Bold Semi-Condensed";
            size = 10.0;
          };

        }
      ];
    };
    extraConfig = ''
      exec_always setxkbmap -option caps:swapescape  # Bind cap lock to escape
      exec_always sh -c 'nm-applet'  # sudo apt install nm-applet
      exec_always sh -c 'eval "$($HOME/anaconda3/bin/conda shell.zsh hook)"'  # launch conda
      exec_always sh -c 'eval $(ssh-agent) && ssh-add ~/.ssh/unnax'
      exec_always sh -c 'eval "$(register-python-argcomplete airflow)"' # enable airflow autocompletion https://airflow.apache.org/docs/apache-airflow/1.10.6/howto/cli-completion.html

      # autostart
      exec_always sh -c 'xrandr --output eDP-1 --auto --output DP-1-1 --auto --right-of DP-1-3'

      #exec_always start-pulseaudio-x11

      # Workspace
      exec_always --no-startup-id i3-msg 'workspace "1: Web"; exec firefox'
      exec_always --no-startup-id i3-msg 'workspace "2: Terminal";'
      exec_always --no-startup-id i3-msg 'workspace "4: Code";'
      exec_always --no-startup-id i3-msg 'workspace "7: Doc";'
      exec_always --no-startup-id i3-msg 'workspace "7: Doc";'
      exec_always --no-startup-id i3-msg 'workspace "0: Chat"; exec slack;'
      exec_always --no-startup-id i3-msg 'workspace "0: Chat"; exec spotify;'
      # exec --no-startup-id urxvt -name dropdown -e tmux
      # exec --no-startup-id urxvt -name math -e ~/.config/i3/dropdowncalc

      # Workspace on displays
      # Use `xrandr --current`
      workspace "1: Web"          output DP-1-3 eDP-1
      workspace "2: Terminal"     output DP-1-3 eDP-1
      workspace "3: Terminal"     output DP-1-3 eDP-1
      workspace "4: Code"         output DP-1-3 eDP-1
      workspace "5: Code"         output DP-1-3 eDP-1
      workspace "6: Code"         output DP-1-1 eDP-1
      workspace "7: Doc"          output DP-1-1 eDP-1
      workspace 8                 output DP-1-1 eDP-1
      workspace "9"               output DP-1-3 eDP-1
      workspace "0: Chat"         output DP-1-1 eDP-1


      # Bind icon to tabs
      for_window [class="(?i)firefox"] title_format "<tt></tt><span foreground='#FF6611'>  </span><tt> </tt>"
      for_window [class="(.*)terminal(.*)"] title_format "<tt></tt><span foreground='#00FF00' background='#000000'>  </span><tt> </tt>%title"
      for_window [class="Konsole"] title_format "<tt></tt><span foreground='#00FF00' background='#000000'>  </span><tt> </tt>%title"
      for_window [class="(.*)Chromium-browser(.*)"] title_format "<tt></tt><span foreground='#367dd0' background='#d9e5f4'>  </span><tt> </tt>%title"
      for_window [class="Evolution"] title_format "<tt></tt><span foreground='#FFFFFF' >  </span><tt> </tt>%title"
      for_window [title=".* Evolution"] title_format "<tt></tt><span foreground='#FFFFFF' >  </span><tt> </tt>%title"
      for_window [class="Slack"] title_format "<tt></tt><span foreground='#FFFFFF' >  </span><tt> </tt>
      for_window [class="Signal"] title_format "<tt></tt><span background='#2090ea' foreground='#FFFFFF' >  </span><tt> </tt>%title"
      for_window [class="VirtualBox Machine"] title_format "<tt></tt><span  background='#073624' foreground='#AAAAFF' >  </span><tt> </tt>%title"
      for_window [class="VirtualBox Manager"] title_format "<tt></tt><span  background='#073642' foreground='#AAAAFF' >  </span><tt> </tt>%title"
      for_window [class="libreoffice-writer"] title_format "<tt></tt><span  background='#073642' foreground='#adc5e7' >  </span><tt> </tt>%title"
      for_window [class="libreoffice-calc"] title_format "<tt></tt><span  background='#073642' foreground='#add58a' >  </span><tt> </tt>%title"
      for_window [class="libreoffice-impress"] title_format "<tt></tt><span  background='#073642' foreground='#d07e7e' >  </span><tt> </tt>%title"
      for_window [class="Spotify Prenium"] title_format "<tt></tt><span foreground='#1DB954' >  </span><tt> </tt>%title"
      for_window [class="(.*)Code"] title_format "<tt></tt><span background='#0078d7' > 󰨞 </span><tt> </tt>%title"
      for_window [class="Sublime Text"] title_format "<tt></tt><span foreground='#4C4C4C' >  </span><tt> </tt>
    '';
  };
}
