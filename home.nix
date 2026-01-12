{ config, lib, pkgs, unstable, inputs, system, ... }:
# References this implementation
# https://github.com/srid/nix-config/blob/705a70c094da53aa50cf560179b973529617eb31/nix/home.nix
with lib;
let
  allPlatformImports = [
    ./dotfiles.nix
    ./apps/bat.nix
    ./apps/git.nix
    ./apps/neovim.nix
    ./apps/tmux.nix
    ./apps/zsh.nix
  ];
  linuxImports = [
    ./apps/i3.nix
    ./apps/textfox.nix
    ./apps/firefox.nix
    ./apps/linux.nix
  ];
  macosImports = [
    ./apps/macos.nix
  ];
  keyboardSubModule = types.submodule {
    options = {
      options = mkOption {
        type = types.listOf types.str;
        default = [ " caps:escape_shifted_capslock" ];
        example = [ "caps:escape" ];
        description = ''
          X keyboard options; layout switching goes here.
        '';
      };
    };
  };
in
{
  nixpkgs.config.allowUnfree = true;
  home.enableNixpkgsReleaseCheck = false;
  fonts.fontconfig.enable = true;

  home.username = "antoineauer";
  home.homeDirectory = "/Users/antoineauer";

  imports =
    if system == "x86_64-linux"
    then (allPlatformImports ++ linuxImports)
    else (allPlatformImports ++ macosImports);

  home.stateVersion = "25.05";


  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w" # Sublime Text 4 currently needs this, see https://github.com/sublimehq/sublime_text/issues/5984
  ];

  # environment.
  home.packages = with pkgs; [

    # -----------------------------------------------------------------
    # SHELL ET UTILITAIRES DE LIGNE DE COMMANDE (CLI)
    # -----------------------------------------------------------------
    direnv
    eza # ls like
    zsh # Shell Zsh (nécessaire si vous utilisez Oh My Zsh)
    oh-my-zsh # Framework pour la gestion de la configuration Zsh
    carapace # Complétion de commandes génériques
    fzf # Sélecteur flou interactif en ligne de commande
    screen # Gestionnaire de sessions de terminal
    bat # Afficheur de fichiers avec coloration syntaxique (alternative à `cat`)
    htop # Moniteur de processus interactif
    wget # Utilitaire de téléchargement de fichiers
    unzip # Décompresseur de fichiers .zip
    zip # Compresseur de fichiers .zip
    # home-manager                # Utile si vous construisez avec NixOS (laissez commenté si vous utilisez Flake 'nix run')
    # nushell                     # Shell moderne (https://www.nushell.sh/)

    # -----------------------------------------------------------------
    # OUTILS DE DÉVELOPPEMENT ET GESTION DE CODE
    # -----------------------------------------------------------------
    git # Système de contrôle de version
    tig # Interface utilisateur en mode texte (TUI) pour Git
    nodejs_22 # Environnement d'exécution JavaScript
    # sublime4                    # Éditeur de texte Sublime Text 4
    # vscode                      # Éditeur de code Visual Studio Code

    # -----------------------------------------------------------------
    # PYTHON
    # -----------------------------------------------------------------
    basedpyright
    (python312.withPackages (p: [
      p.ipython # Shell interactif pour Python
      p.pandas # Librairie d'analyse et manipulation de données
      p.flake8
      p.black
      p.isort
      p.vulture
      p.pytest
      p.debugpy
    ]))
    pipx # Pour installer et exécuter des applications Python dans des environnements isolés
    uv # Outil d'installation de dépendances Python, rapide (alternatif à pip/pipenv)
    virtualenv # Outil pour créer des environnements Python isolés
    # pyenv                       # Gestionnaire de versions Python (https://github.com/pyenv/pyenv)
    # conda                       # Gestionnaire de paquets et d'environnement (laissé commenté car souvent problématique avec Nix/Mac)

    # -----------------------------------------------------------------
    # RUST
    # -----------------------------------------------------------------
    rustup
    lldb
    gdb

    # -----------------------------------------------------------------
    # RÉSEAUX, DEVOPS ET CLOUD
    # -----------------------------------------------------------------
    # awscli2                       # Interface de ligne de commande pour AWS
    # kubectl                       # Client pour le contrôle des clusters Kubernetes
    # kubectx                       # Utilitaires pour basculer facilement entre contextes (kubectx) et namespaces (kubens)
    nmap # Scanner de ports et d'exploration de réseau
    openssl # Outils de cryptographie et de gestion de certificats
    httpie # Client HTTP convivial (alternative à `curl`)
    # ollama                      # Plateforme pour grands modèles de langage (LLMs) locaux
    # openvpn3                    # Client VPN

    # -----------------------------------------------------------------
    # MANIPULATION DE DONNÉES ET BASES DE DONNÉES
    # -----------------------------------------------------------------
    jq # Processeur JSON en ligne de commande
    # mariadb                       # Client de base de données MariaDB
    # marimo                        # Framework Python pour créer des applications de données interactives
    dejsonlz4 # Outil pour décoder les fichiers de sauvegarde de Firefox (jsonlz4)
    # mysql                       # Alias ou client MySQL (souvent remplacé par mariadb)
    # redis                       # Client pour le serveur de données Redis

    # -----------------------------------------------------------------
    # COMPILATEURS ET BIBLIOTHÈQUES SYSTÈME
    # -----------------------------------------------------------------
    gcc # Compilateur GNU C
    gcc-unwrapped # Version non enveloppée de GCC
    zlib # Librairie de compression de données

    # -----------------------------------------------------------------
    # DESIGN ET DIVERS
    # -----------------------------------------------------------------
    d2 # Language de description de diagrammes (https://d2lang.com/tour/intro)
    nerd-fonts.meslo-lg
    nerd-fonts._0xproto
    nerd-fonts.ubuntu
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    oh-my-posh

    # -----------------------------------------------------------------
    # APPLICATIONS GRAPHIQUES (GUI)
    # -----------------------------------------------------------------
    google-chrome # Navigateur web Google Chrome
    # spotify # Application de streaming musical
    # konsole                     # Émulateur de terminal KDE (probablement à déplacer dans linux.nix)
    # libreoffice                 # Suite bureautique
    # nemo                        # Gestionnaire de fichiers (Cinnamon/Linux - probablement à déplacer dans linux.nix)
    # slack                       # Application de communication
    # thunderbird                 # Client de messagerie
    # liferea                     # Lecteur de flux RSS/Atom

    # -----------------------------------------------------------------
    # DÉPENDANCES ET BIBLIOTHÈQUES (Généralement spécifiques à Linux/X11 ou à ignorer)
    # -----------------------------------------------------------------
    # glibc                       # Librairie C de GNU (généralement fournie par le système d'exploitation)
    # libstdcxx5                  # Librairie standard C++
    # libgcc                      # Librairie de support pour GCC
    # libxcb                      # (plover) Librairie X protocol C-language Binding (Spécifique à X11/Linux)
    # libxcb-cursor0              # (plover) Librairie X protocol C-language Binding (Spécifique à X11/Linux)
    # qt5-qtstyleplugins          # (plover) Plugins de style Qt5
    # xcb-util                    # (plover) Librairie d'utilitaires XCB
    # plover.dev                  # Application (Sténographie)
  ];
  systemd.user.services.ollama = {
    Unit = {
      Description = "Ollama Service";
      After = "network-online.target";
    };
    Install = {
      # WantedBy = [ "default.target" ];      # Activate by default
    };
    Service = {
      ExecStart = "${pkgs.ollama}/bin/ollama serve";
      Restart = "always";
      RestartSec = "3";
      Environment = "PATH=${pkgs.ollama}/bin:$PATH";
    };
  };

  home.sessionVariables = with pkgs;{
    EDITOR = "nvim";
    # LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib/"; # fix the problem of dynamic link in python package BUT https://discourse.nixos.org/t/new-install-nix-wants-glibc-2-38-debian-12-has-2-36/36109/5
    # find /usr -name 'libstdc++.so.6' 2>/dev/null : /usr/lib/x86_64-linux-gnu/libstdc++.so.6
    SHELL = "${pkgs.zsh}/bin/zsh";
    AUTOENV_ENABLE_LEAVE = "yes";
    AUTOENV_VIEWER = "bat";
    NVIM_CONFIG_DIR = "$HOME/.config/home-manager/apps/lua/";
  };

  programs = {
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-dash
        gh-markdown-preview
      ];
      settings = {
        editor = "micro";
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

    home-manager = {
      enable = true;
    };

    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-plug
        nerdtree
      ];
      settings = { ignorecase = true; };
    };

  };
}
