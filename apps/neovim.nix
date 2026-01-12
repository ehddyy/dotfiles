{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # --- BINARIES (LSP, Linters, Formatters) ---
    extraPackages = with pkgs; [
      # Base
      fd
      ripgrep
      lazygit
      nodejs

      # LSP & Linters
      nixd
      nixpkgs-fmt
      lua-language-server
      stylua
      pyright
      marksman
      gopls
      yaml-language-server

      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.vscode-langservers-extracted
      nodePackages.eslint_d

      # Formatters (Conform)
      yamlfmt
      prettierd
      stylua

      # Debug & Others
      python3Packages.debugpy
      lldb
    ];

    # --- SYSTEM PLUGINS ---
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-c
          tree-sitter-cpp
          tree-sitter-dockerfile
          tree-sitter-fish
          tree-sitter-go
          tree-sitter-html
          tree-sitter-json
          tree-sitter-latex
          tree-sitter-lua
          tree-sitter-nix
          tree-sitter-python
          tree-sitter-r
          tree-sitter-regex
          tree-sitter-rust
          tree-sitter-sql
          tree-sitter-toml
          tree-sitter-vim
          tree-sitter-yaml
        ]
      ))
      nvim-jqx
    ];

    extraLuaConfig = ''
      require("config.lazy")

      vim.cmd.colorscheme("onedark")
    '';
  };
}
