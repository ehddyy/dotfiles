{ config, lib, pkgs, ... }:

{
	programs.git = {
	  enable = true;
	  userName = "Antoine Auer";
	  userEmail = "antoine.auer@powens.com";
	  difftastic = {
	    display = "side-by-side-show-both";
	    enable = true;
	  };
	  extraConfig = {
	    advice = {
	      statusHints = false;
	    };
	    color = {
	      branch = true;
	      diff = true;
	      interactive = true;
	      log = true;
	      status = true;
	      ui = true;
	    };
	    core = {
	      pager = "bat";
	    };
	    push = {
	      default = "matching";
	    };
	    pull = {
	      rebase = false;
	    };
	    init = {
	      defaultBranch = "main";
	    };
	  };
	  ignores = [
	    "*.log"
	    "*.out"
	    ".DS_Store"
	    "bin/"
	    "dist/"
	    "result"
	    ".venv"
	    ".vscode"
	  ];
	};
}