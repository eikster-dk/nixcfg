{ config, pkgs, ... }:
let
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
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        (fromGithub "echasnovski" "mini.pairs" "v0.13.0" "lszfplyL9Mj/2gQz7ITzRdru9djPxJKB2ncvV0MaE0k=")

        harpoon2
        oil-nvim
        trouble-nvim
        cloak-nvim
        flash-nvim

        # UI
        catppuccin-nvim
        gitsigns-nvim
        indent-blankline-nvim
        lualine-nvim
        noice-nvim
        nvim-web-devicons
        which-key-nvim

        telescope-nvim
        telescope-github-nvim

        # Coding
        nvim-lspconfig
        conform-nvim
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp-emoji
        cmp-calc
        cmp-nvim-lsp
        cmp-nvim-lsp-signature-help
        cmp_luasnip

        fidget-nvim
        luasnip
        friendly-snippets
        neodev-nvim

        #neogen
        nvim-surround
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

        # treesitter injections for home-manager
        hmts-nvim
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
      typescript-language-server
      vscode-css-languageserver-bin
      vscode-html-languageserver-bin
      vscode-json-languageserver-bin
      yaml-language-server
      yamllint
    ];

    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink ./v2;
    };

    ## makes it possible to make changes to the config file and have them hot reloaded. Even tho this is not ideal, it's better than nothing.
    ## To make a "writable" symlink an absolute path is required when working from a flake
    #xdg.configFile."nvim" = {
    #  source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/personal/dotfiles/modules/neovim/config";
    #};
  }
