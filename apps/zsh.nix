{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#ff00ff,bg=cyan,bold,underline";
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "brackets"
      ];
    };
    zsh-abbr = {
      enable = true;
      abbreviations = {
        l = "less";
      };
    };
    dirHashes = {
      dev = "$HOME/dev";
      dwh = "$HOME/dev/dwh";
      meet = "$HOME/Documents/meetings";
      projects = "$HOME/Documents/projects";
    };
    history = {
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignorePatterns = [
        "cd *"
        "rm *"
        "ls *"
        "ll *"
        "la *"
        "cat*"
      ];
      save = 10000;
      size = 10000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        # "aws"
        # "colorize"
        # "command-not-found"
        # "debian"
        # "docker"
        # "docker-compose"
        "fzf"
        # "gh"
        "git"
        # "httpie"
        # "jira"
        # "kubectl"
        # "minikube"
        # "pep8"
        # "pip"
        # "postgres"
        # "python"
        # "rust"
        # "screen"
        # "ssh-agent"
        # "sudo"
        # "terraform"
        # "transfer"
        # "ubuntu"
        "vi-mode"
        # "web-search"
      ];
      theme = "robbyrussell";
    };
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
    ];
    shellAliases = {
      ".." = "cd ..";
      cp = "cp -v";
      rm = "rm -I";
      mv = "mv -iv";
      ln = "ln -sriv";
      xclip = "xclip -selection c";
      sc = "screen -S";
      sr = "screen -r";
      sl = "screen -ls  ";

      cat = "bat";
      ls = "eza --icons --sort=name";
      ll = "eza --icons --sort=name";
      la = "eza --icons -l -a --sort=name";
      tree = "eza --icons --tree";

      switch = "home-manager switch && exec zsh";
      v = "nvim";
      vim = "nvim";
      n = "nvim";
      vimrc = "nvim ~/Documents/dotfiles/.vimrc";
      zshrc = "nvim ~/Documents/dotfiles/.zshrc";

      dev = "cd $HOME/dev";
      meetings = "nvim ~/Documents/docs/meetings";
      projects = "nvim ~/Documents/docs/projects/";
      dotfiles = "nvim ~/Documents/dotfiles/";
      manager = "cd ~/.config/home-manager/ && nvim";

      flake8 = "flake8 --max-line-length 160 ";

      # Poetry
      pol = "poetry lock";
      poi = "poetry install";
      poin = "poetry install --no-root";
      poiwd = "poetry install --without dev";
      poa = "poetry add";
      poad = "poetry add --dev";

      # UV
      uv = "noglob uv";
      uva = "uv add";
      uvad = "uv add --dev";
      uvexp = "uv export --format requirements-txt --no-hashes --output-file requirements.txt
      --quiet";
      uvl = "uv lock";
      uvlr = "uv lock --refresh";
      uvlu = "uv lock --upgrade";
      uvp = "uv pip";
      uvpi = "uv pip install";
      uvpy = "uv python";
      uvr = "uv run";
      uvrm = "uv remove";
      uvs = "uv sync";
      uvsr = "uv sync --refresh";
      uvsu = "uv sync --upgrade";
      uvup = "uv self update";
      uvv = "uv venv";
    };
    initContent = ''
      source $HOME/.config/home-manager/dotfiles/key-bindings.zsh
      source $HOME/.config/home-manager/dotfiles/completion.zsh

      # JIRA Plugin
      JIRA_URL=
      JIRA_NAME=;
      JIRA_RAPID_VIEW=;
      JIRA_RAPID_BOARD=true;
      JIRA_DEFAULT_ACTION=dashboard;

      function jira_branch() {
        # Get name of the branch
        issue_arg=$(git rev-parse --abbrev-ref HEAD)
        # Strip prefixes like feature/ or bugfix/

        regex='NA-[0-9]+'
        issue_arg=$(git rev-parse --abbrev-ref HEAD | grep -oE $regex)

        # Return the value
        echo $issue_arg
      }
      PATH=$PATH:$HOME/.local/bin

      # Fix npm Install
      # mkdir -p ~/.npm-global/lib
      # npm config set prefix '~/.npm-global'
      PATH=~/.npm-global/bin:$PATH
      PATH=$PATH:$HOME/dev/backend/scripts

      eval "$(oh-my-posh init zsh --config $HOME/.config/home-manager/dotfiles/oh-my-posh.json)"

      # By Passing up key to search through history
      autoload -Uz up-line-or-search down-line-or-search
      zle -N up-line-or-search
      zle -N down-line-or-search
      bindkey '^[[A' up-line-or-search
      bindkey '^[[B' down-line-or-search
      bindkey $terminfo[kcud1] down-line-or-history
      bindkey $terminfo[kcuu1] up-line-or-history

      # setxkbmap -option caps:swapescape

    '';
  };
}
