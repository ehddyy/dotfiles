{ config, lib, pkgs, ... }:

{
  home.file = {
    "nvim/lua".source = ./apps/lua;
    ".config/nvim/lua".source = ./apps/lua;
    ".sqlfluff".source = ./dotfiles/apps/sqlfluff;

    # ".config/zellij".source = ./zellij;
    # ".config/terminator/plugins".source = ./terminator;
    # ".config/htop/htoprc".source = ./home/htoprc;

    # ".config/htop/htoprc".source = ./home/htoprc;
    ".markdownlint.json".text = ''
      {
            "default": true,
            "MD013": false
      }
    '';

    # Default application opening
    ".config/mimeapps.list".text = ''
      [Default Applications]
        text/html=firefox.desktop
        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
        x-scheme-handler/about=google-chrome.desktop
        x-scheme-handler/unknown=google-chrome.desktop
        x-scheme-handler/chrome=firefox.desktop
        application/x-extension-htm=firefox.desktop
        application/x-extension-html=firefox.desktop
        application/x-extension-shtml=firefox.desktop
        application/xhtml+xml=firefox.desktop
        application/x-extension-xhtml=firefox.desktop
        application/x-extension-xht=firefox.desktop

        text/plain=sublime_text.desktop
        text/markdown=sublime_text.desktop

      [Added Associations]
        text/plain=org.gnome.Evince.desktop;
        image/png=shotwell-viewer.desktop;
        x-scheme-handler/http=firefox.desktop;
        x-scheme-handler/https=firefox.desktop;
        x-scheme-handler/chrome=firefox.desktop;
        text/html=firefox.desktop;
        application/x-extension-htm=firefox.desktop;
        application/x-extension-html=firefox.desktop;
        application/x-extension-shtml=firefox.desktop;
        application/xhtml+xml=firefox.desktop;
        application/x-extension-xhtml=firefox.desktop;
        application/x-extension-xht=firefox.desktop;
    '';
  };
}
