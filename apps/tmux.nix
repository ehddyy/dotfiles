{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.yank
      tmuxPlugins.continuum
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
    # extraConfig = ''
    #   set-option -g prefix M-a # M = alt

    #   # move tmux copy buffer into x clipboard
    #   bind -n M-y run "tmux save-buffer - | xclip -i"

    #   # Enable mouse control (clickable windows, panes, resizable panes)
    #   set -g mouse on

    #   # -- display -------------------------------------------------------------------

    #   set -g base-index 1           # start windows numbering at 1
    #   setw -g pane-base-index 1     # make pane numbering consistent with windows

    #   setw -g automatic-rename on   # rename window to reflect current program
    #   set -g renumber-windows on    # renumber windows when a window is closed

    #   set -g set-titles on          # set terminal title

    #   set -g display-panes-time 800 # slightly longer pane indicators display time
    #   set -g display-time 1000      # slightly longer status messages display time

    #   set -g status-interval 10     # redraw status line every 10 seconds

    #   # clear both screen and history
    #   bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history

    #   # activity
    #   set -g monitor-activity on
    #   set -g visual-activity off

    #   # Resize
    #   bind -n C-Down resize-pane -D 5
    #   bind -n C-Up resize-pane -U 5
    #   bind -n C-Left resize-pane -L 5
    #   bind -n C-Right resize-pane -R 5

    #   # -- CRUD -------------------------------------------------------------------

    #   # Pane
    #   bind -n M-b  split-window -v -c '#{pane_current_path}'
    #   bind -n M-f  split-window -h -c 'lf'
    #   bind -n M-n  split-window -h -c '#{pane_current_path}'
    #   unbind '"'
    #   unbind %
    #   bind -n M-d kill-pane # Kill pane


    #   # Session
    #   bind -n M-t new-session

    #   # -- Navigating -------------------------------------------------------------------

    #   # Pane
    #   bind -n M-Left select-pane -L
    #   bind -n M-Right select-pane -R
    #   bind -n M-Up select-pane -U
    #   bind -n M-Down select-pane -D
    #   bind -n M-h select-pane -L
    #   bind -n M-l select-pane -R
    #   bind -n M-k select-pane -U
    #   bind -n M-j select-pane -D

    #   # Session
    #   bind -n M-! next-window -a
    #   bind -n M-: previous-window -a


    #   # find session
    #   bind C-f command-prompt -p find-session 'switch-client -t %%'

    #   # -- DESIGN TWEAKS -------------------------------------------------------------------

    #   # don't do anything when a 'bell' rings
    #   set -g visual-activity off
    #   set -g visual-bell off
    #   set -g visual-silence off
    #   setw -g monitor-activity off
    #   set -g bell-action none

    #   # clock mode
    #   setw -g clock-mode-colour colour1

    #   # copy mode
    #   setw -g mode-style 'fg=colour1 bg=colour18 bold'

    #   # pane borders
    #   set -g pane-border-style 'fg=colour1'
    #   set -g pane-active-border-style 'fg=colour3'

    #   # statusbar
    #   set -g status-position bottom
    #   set -g status-justify left
    #   set -g status-style 'fg=colour1'
    #   set -g status-left ' '
    #   set -g status-right '%Y-%m-%d %H:%M '
    #   set -g status-right-length 50
    #   set -g status-left-length 10

    #   setw -g window-status-current-style 'fg=colour0 bg=colour1 bold'
    #   setw -g window-status-current-format ' #I #W #F '

    #   setw -g window-status-style 'fg=colour1 dim'
    #   setw -g window-status-format ' #I #[fg=colour7]#W #[fg=colour1]#F '

    #   setw -g window-status-bell-style 'fg=colour2 bg=colour1 bold'

    #   # messages
    #   set -g message-style 'fg=colour2 bg=colour0 bold'
    # '';
  };
}
