{ config, lib, pkgs, ... }:

{
  programs.nushell = {
    enable = false;
    configFile.source = "${config.home.homeDirectory}/Documents/dotfiles/config.nu";
    # historyFile.source = $HOMEhistory.txt;
    extraConfig = ''
      	    $env.config = {
      	      show_banner: false,
      	      edit_mode: vi,
      	      history: {
      	        max_size: 100_000           # Session has to be reloaded for this to take effect
      	        sync_on_enter: true         # Enable to share history between multiple sessions, else you have to close the session to write history to file
      	        file_format: "plaintext"    # "sqlite" or "plaintext"
      	        isolation: false            # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
      	      },
      	      completions: {
      	        case_sensitive: false       # set to true to enable case-sensitive completions
      	        quick: true                 # set this to false to prevent auto-selecting completions when only one remains
      	        partial: true               # set this to false to prevent partial filling of the prompt
      	        algorithm: "prefix"         # prefix or fuzzy
      	        external: {
      	            enable: true            # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
      	            max_results: 100        # setting it lower can improve completion performance at the cost of omitting some options
      	            completer: null         # check 'carapace_completer' above as an example
      	        }
      	        use_ls_colors: true         # set this to true to enable file/path/directory completions using LS_COLORS 
      	      },
      	      plugin_gc: {
      	        default: {
      	          enabled: true             # set to false to never automatically stop plugins
      	          stop_after: 10sec         # how long to wait after the plugin is inactive before stopping it
      	        }
      	        plugins: {
      	          polars: {
      	            enabled: true
      	          }
      	        }
      	      },
      	      menus: [
      	        {
      	          name: fzf_history_menu_fzf_ui
      	          only_buffer_difference: false
      	          marker: "# "
      	          type: {
      	              layout: columnar
      	              columns: 4
      	              col_width: 20
      	              col_padding: 2
      	          }
      	          style: {
      	              text: green
      	              selected_text: green_reverse
      	              description_text: yellow
      	          }
      	          source: { |buffer, position|
      	              open -r $nu.history-path | fzf +s --tac | str trim
      	              | where $it =~ $buffer
      	              | each { |v| {value: ($v | str trim) } }
      	          }
      	        },
      	        {
      	            name: fzf_menu_nu_ui
      	            only_buffer_difference: false
      	            marker: "# "
      	            type: {
      	                layout: list
      	                page_size: 10
      	            }
      	            style: {
      	                text: "#66ff66"
      	                selected_text: { fg: "#66ff66" attr: r }
      	                description_text: yellow
      	            }
      	            source: { |buffer, position|
      	                open -r $nu.history-path
      	                | fzf -f $buffer
      	                | lines
      	                | each { |v| {value: ($v | str trim) } }
      	            }
      	        }
      	      ],
      	      keybindings: [
      	        {
      	          name: change_dir_with_fzf
      	          modifier: control
      	          keycode: char_f
      	          mode: emacs
      	          event: {
      	            send: executehostcommand,
      	            cmd: "cd (ls | where type == dir | each { |it| $it.name} | str collect (char nl) | fzf | decode utf-8 | str trim)"
      	          }
      	        },
      	        {
      	          name: fuzzy_history
      	          modifier: control
      	          keycode: char_r
      	          mode: emacs
      	          event: {
      	            send: executehostcommand
      	            cmd: "commandline (history | each { |it| $it.command } | uniq | reverse | str collect (char nl) | fzf --layout=reverse --height=40% -q (commandline) | decode utf-8 | str trim)"
      	          }
      	        },
      	        # {
      	        #   name: fzf_history_menu_fzf_ui
      	        #   modifier: control
      	        #   keycode: char_r
      	        #   mode: [emacs, vi_normal, vi_insert]
      	        #   event: { send: menu name: fzf_history_menu_fzf_ui }
      	        # }
      	        {
      	          name: fzf_menu_nu_ui
      	          modifier: control
      	          keycode: char_w
      	          mode: [emacs, vi_normal, vi_insert]
      	          event: { send: menu name: fzf_menu_nu_ui }
      	        }
      	      ]
      	    }

      	    def apishell [url:string] {
      	      cd ~/dev/powens-compose
      	      docker exec -it apishell bash -c $"python3 ./apishell.py ($url)"
      	    }
      	    $env.PATH = ($env.PATH | split row (char esep) | append "$HOME.cargo/bin")

      	    source $HOME.oh-my-posh.nu
      	  '';
    environmentVariables = {
      PYTHONPATH = "$HOMEdev/backend/scripts:$HOMEdev/backend:$HOMEdev/weboob:$HOMEdev/anonymization";
    };
    shellAliases = {

      # System
      ".." = "cd ..";
      cp = "cp -v";
      rm = "rm -t";
      mv = "mv -iv";
      ll = "ls -l";
      la = "ls -la";
      ln = "ln -sriv";
      xclip = "xclip -selection c";

      # Path
      backend = "cd $HOMEdev/powens-compose";
      dwh = "cd $HOMEdev/dwh";
      projects = "cd $HOMEDocuments/projects/";
      meetings = "vim $HOMEDocuments/meetings/meetings.md";

      vimrc = "vim $env.HOME/.vimrc";
      v = "vim";

      gitinit = "ssh-add $env.HOME/.ssh/unnax";
      #
      # GIT Aliases
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
      #
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gapa = "git add --patch";
      gau = "git add --update";
      gav = "git add --verbose";
      gam = "git am";
      gama = "git am --abort";
      gamc = "git am --continue";
      gamscp = "git am --show-current-patch";
      gams = "git am --skip";
      gap = "git apply";
      gapt = "git apply --3way";
      gbs = "git bisect";
      gbsb = "git bisect bad";
      gbsg = "git bisect good";
      gbsn = "git bisect new";
      gbso = "git bisect old";
      gbsr = "git bisect reset";
      gbss = "git bisect start";
      gbl = "git blame -w";
      gb = "git branch";
      gba = "git branch --all";
      gbd = "git branch --delete";
      gbD = "git branch --delete --force";
      gbm = "git branch --move";
      gbnm = "git branch --no-merged";
      gbr = "git branch --remote";
      gco = "git checkout";
      gcor = "git checkout --recurse-submodules";
      gcb = "git checkout -b";
      gcB = "git checkout -B";
      gcd = "git checkout develop";
      gcm = "git checkout main";
      gcp = "git cherry-pick";
      gcpa = "git cherry-pick --abort";
      gcpc = "git cherry-pick --continue";
      gclean = "git clean --interactive -d";
      gcl = "git clone --recurse-submodules";
      gcas = "git commit --all --signoff";
      gcasm = "git commit --all --signoff --message";
      gcmsg = "git commit --message";
      gcsm = "git commit --signoff --message";
      gc = "git commit --verbose";
      gca = "git commit --verbose --all";
      "gca!" = "git commit --verbose --all --amend";
      "gcan!" = "git commit --verbose --all --no-edit --amend";
      "gcans!" = "git commit --verbose --all --signoff --no-edit --amend";
      "gcann!" = "git commit --verbose --all --date=now --no-edit --amend";
      "gc!" = "git commit --verbose --amend";
      gcn = "git commit --verbose --no-edit";
      "gcn!" = "git commit --verbose --no-edit --amend";
      gcs = "git commit -S";
      gcss = "git commit -S -s";
      gcssm = "git commit -S -s -m";
      gcf = "git config --list";
      gdct = "git describe --tags (git rev-list --tags --max-count=1)";
      gd = "git diff";
      gdca = "git diff --cached";
      gdcw = "git diff --cached --word-diff";
      gds = "git diff --staged";
      gdw = "git diff --word-diff";
      gdup = "git diff @{upstream}";
      gdt = "git diff-tree --no-commit-id --name-only -r";
      gf = "git fetch";
      gfa = "git fetch --all --tags --prune";
      gfo = "git fetch origin";
      gg = "git gui citool";
      gga = "git gui citool --amend";
      ghh = "git help";
      glgg = "git log --graph";
      glgga = "git log --graph --decorate --all";
      glgm = "git log --graph --max-count=10";
      glod = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'";
      glods = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short";
      glol = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'";
      glola = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all";
      glols = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat";
      glo = "git log --oneline --decorate";
      glog = "git log --oneline --decorate --graph";
      gloga = "git log --oneline --decorate --graph --all";
      glp = "git log --pretty=<format>";
      glg = "git log --stat";
      glgp = "git log --stat --patch";
      gm = "git merge";
      gma = "git merge --abort";
      gmc = "git merge --continue";
      gms = "git merge --squash";
      gmff = "git merge --ff-only";
      gmom = "git merge origin/(git_main_branch)";
      gmum = "git merge upstream/(git_main_branch)";
      gmtl = "git mergetool --no-prompt";
      gmtlvim = "git mergetool --no-prompt --tool=vimdiff";
      gl = "git pull";
      gpr = "git pull --rebase";
      gprv = "git pull --rebase -v";
      gpra = "git pull --rebase --autostash";
      gprav = "git pull --rebase --autostash -v";
      gprom = "git pull --rebase origin (git_main_branch)";
      gpromi = "git pull --rebase=interactive origin (git_main_branch)";
      gprum = "git pull --rebase upstream (git_main_branch)";
      gprumi = "git pull --rebase=interactive upstream (git_main_branch)";
      ggpull = "git pull origin \"(git_current_branch)\"";
      ggl = "git pull origin (current_branch)";
      gluc = "git pull upstream (git_current_branch)";
      glum = "git pull upstream (git_main_branch)";
      gp = "git push";
      gpd = "git push --dry-run";
      "gpf!" = "git push --force";
      ggf = "git push --force origin (current_branch)";
      gpf = "git push --force-with-lease --force-if-includes";
      ggfl = "git push --force-with-lease origin (current_branch)";
      gpsup = "git push --set-upstream origin (git_current_branch)";
      gpsupf = "git push --set-upstream origin (git_current_branch) --force-with-lease --force-if-includes";
      gpv = "git push --verbose";
      gpoat = "git push origin --all and git push origin --tags";
      gpod = "git push origin --delete";
      ggpush = "git push origin \"(git_current_branch)\"";
      ggp = "git push origin (current_branch)";
      gpu = "git push upstream";
      grb = "git rebase";
      grba = "git rebase --abort";
      grbc = "git rebase --continue";
      grbi = "git rebase --interactive";
      grbo = "git rebase --onto";
      grbs = "git rebase --skip";
      grbd = "git rebase (git_develop_branch)";
      grbm = "git rebase (git_main_branch)";
      grbom = "git rebase origin/(git_main_branch)";
      grbum = "git rebase upstream/(git_main_branch)";
      grf = "git reflog";
      gr = "git remote";
      grv = "git remote --verbose";
      gra = "git remote add";
      grrm = "git remote remove";
      grmv = "git remote rename";
      grset = "git remote set-url";
      grup = "git remote update";
      grh = "git reset";
      gru = "git reset --";
      grhh = "git reset --hard";
      grhk = "git reset --keep";
      grhs = "git reset --soft";
      gpristine = "git reset --hard and git clean --force -dfx";
      gwipe = "git reset --hard and git clean --force -df";
      groh = "git reset origin/(git_current_branch) --hard";
      grs = "git restore";
      grss = "git restore --source";
      grst = "git restore --staged";
      grev = "git revert";
      grm = "git rm";
      grmc = "git rm --cached";
      gcount = "git shortlog --summary -n";
      gsh = "git show";
      gsps = "git show --pretty=short --show-signature";
      gstall = "git stash --all";
      gstu = "git stash --include-untracked";
      gstaa = "git stash apply";
      gstc = "git stash clear";
      gstd = "git stash drop";
      gstl = "git stash list";
      gstp = "git stash pop";
      gsta = "git stash push";
      gsts = "git stash show --patch";
      gst = "git status";
      gss = "git status --short";
      gsb = "git status --short -b";
      gsi = "git submodule init";
      gsu = "git submodule update";
      gsd = "git svn dcommit";
      gsr = "git svn rebase";
      gsw = "git switch";
      gswc = "git switch -c";
      gswd = "git switch (git_develop_branch)";
      gswm = "git switch (git_main_branch)";
      gta = "git tag --annotate";
      gts = "git tag -s";
      gignore = "git update-index --assume-unchanged";
      gunignore = "git update-index --no-assume-unchanged";
      gwch = "git whatchanged -p --abbrev-commit --pretty=medium";
      gwt = "git worktree";
      gwtls = "git worktree list";
      gwtmv = "git worktree move";
      gwtrm = "git worktree remove";
      gk = "gitk --all --branches &!";
      gke = "gitk --all (git log --walk-reflogs --pretty=%h) &!";

      #
      # PIP Aliases
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pip
      #
      pipi = "pip install";
      pipu = "pip install --upgrade";
      pipun = "pip uninstall";
      piplo = "pip list -o";

      # Create requirements file;
      pipreq = "pip freeze > requirements.txt";

      # Install packages from requirements file;
      pipir = "pip install -r requirements.txt";

      #
      # Docker Aliases
      # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
      #
      dbl = "docker build"; # Build an image from a Dockerfile;
      dcin = "docker container inspect"; # Display detailed information on one or more containers;
      dcls = "docker container ls"; # List all the running docker containers;
      dclsa = "docker container ls -a"; # List all running and stopped containers;
      dib = "docker image build"; # Build an image from a Dockerfile (same as docker build);
      dii = "docker image inspect"; # Display detailed information on one or more images;
      dils = "docker image ls"; # List docker images;
      dipu = "docker image push"; # Push an image or repository to a remote registry;
      dipru = "docker image prune -a"; # Remove all images not referenced by any container;
      dirm = "docker image rm"; # Remove one or more images;
      dit = "docker image tag"; # Add a name and tag to a particular image;
      dlo = "docker container logs"; # Fetch the logs of a docker container;
      dnc = "docker network create"; # Create a new network;
      dncn = "docker network connect"; # Connect a container to a network;
      dndcn = "docker network disconnect"; # Disconnect a container from a network;
      dni = "docker network inspect"; # Return information about one or more networks;
      dnls = "docker network ls"; # List all networks the engine daemon knows about, including those spanning multiple hosts;
      dnrm = "docker network rm"; # Remove one or more networks;
      dpo = "docker container port"; # List port mappings or a specific mapping for the container;
      dps = "docker ps"; # List all the running docker containers;
      dpsa = "docker ps -a"; # List all running and stopped containers;
      dpu = "docker pull"; # Pull an image or a repository from a registry;
      dr = "docker container run"; # Create a new container and start it using the specified command;
      drit = "docker container run -it"; # Create a new container and start it in an interactive shell;
      drm = "docker container rm"; # Remove the specified container(s);
      "drm!" = "docker container rm -f"; # Force the removal of a running container (uses SIGKILL);
      dst = "docker container start"; # Start one or more stopped containers;
      drs = "docker container restart"; # Restart one or more containers;
      dsta = "docker stop (docker ps -q)"; # Stop all running containers;
      dstp = "docker container stop"; # Stop one or more running containers;
      dtop = "docker top"; # Display the running processes of a container;
      dvi = "docker volume inspect"; # Display detailed information about one or more volumes;
      dvls = "docker volume ls"; # List all the volumes known to docker;
      dvprune = "docker volume prune"; # Cleanup dangling volumes;
      dxc = "docker container exec"; # Run a new command in a running container;
      dxcit = "docker container exec -it"; # Run a new command in a running container in an interactive shell;
    };
  };
}
