{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.features.cli.nvim;
  fromGithub = owner: repo: ref: sha:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${repo}";
      version = ref;
      src = pkgs.fetchFromGitHub {
        owner = owner;
        repo = repo;
        rev = ref;
        sha256 = sha;
      };
    };
in
{
  options.features.cli.nvim.enable = mkEnableOption "enable extended neovim configuration";
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [

        # general plugins
        nui-nvim
        plenary-nvim

        ## theming
        catppuccin-nvim

        ## AI
        # copilot-lua

        ## editor
        harpoon2
        oil-nvim
        cloak-nvim
        flash-nvim
        gitsigns-nvim
        trouble-nvim
        vim-be-good
        which-key-nvim
        better-escape-nvim
        (fromGithub "echasnovski" "mini.ai" "v0.15.0" "sha256-b/776l9nYM9e2atzXrvOk9dCxjzIuW/+iINC/yPv88Y=")
        (fromGithub "echasnovski" "mini.pairs" "v0.15.0" "PtHxLKU1smVTx655r5SINxuz5CJmZWnBW70T8zJ/oxM=")

        ## formatting
        conform-nvim

        # UI
        # indent-blankline-nvim
        lualine-nvim
        noice-nvim
        nvim-notify
        nvim-web-devicons
        (fromGithub "folke" "snacks.nvim" "v2.22.0" "iXfOTmeTm8/BbYafoU6ZAstu9+rMDfQtuA2Hwq0jdcE=")
        # telescope-nvim
        # telescope-github-nvim
        # telescope-fzf-native-nvim



        # Coding
        lazydev-nvim
        nvim-lspconfig
        blink-cmp
        nvim-ts-autotag

        #neogen

        ## treesitter stuff
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
          with plugins; [
            bash
            css
            csv
            dockerfile
            fish
            git_config
            git_rebase
            gitattributes
            gitcommit
            gitignore
            go
            gomod
            gosum
            gowork
            html
            hurl
            javascript
            json
            jq
            lua
            markdown
            markdown_inline
            nix
            query
            sql
            ssh_config
            templ
            typescript
            vim
            yaml
          ]))
        nvim-treesitter-textobjects
      ];
    };

    # LSP stuff, treesitter, formatters, linters
    home.packages = with pkgs; with pkgs.nodePackages_latest; [
      bash-language-server
      cargo
      delve
      gofumpt
      golangci-lint
      golangci-lint-langserver
      gopls
      nil # nix lsp
      nixpkgs-fmt
      pgformatter
      prettier
      shfmt
      stylua
      sumneko-lua-language-server
      tailwindcss-language-server
      templ
      tree-sitter
      vscode-langservers-extracted
      vtsls
      yaml-language-server
      yamllint
    ];

    xdg.configFile."nvim" = {
      source = ./config;
    };
  };
}
