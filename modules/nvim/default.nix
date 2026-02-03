{ inputs, pkgs, ... }:
let
  # move
  move-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "move.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "fedepujol";
      repo = "move.nvim";
      rev = "cccbd4ea9049ca5f99f025ffaddb7392359c7d6a";
      sha256 = "1425mbyvax63m6l7vkwbfi1l863mr86ba11gxa3hqxcgvjpvp638";
    };
  };
in
{
  home.packages = with pkgs; [
    vim-startuptime
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = false;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    plugins = with pkgs.vimPlugins; [
      ####################
      ## Lazy
      lz-n

      ####################
      ## Lua Library
      nui-nvim
      plenary-nvim

      ####################
      ## ColorScheme
      {
        plugin = nightfox-nvim;
        type = "lua";
        config = ''
          require("nightfox").setup({})
          vim.cmd.colorscheme("nightfox")
        '';
      }

      ####################
      ## Font
      nvim-web-devicons

      #####################
      ## UI Library
      {
        plugin = snacks-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/snacks-nvim.lua;
      }

      #####################
      ## Notify
      ## snacks-nvim

      #####################
      ## Auto Completion
      {
        plugin = blink-cmp;
        type = "lua";
        config = builtins.readFile ./plugins/blink-cmp.lua;
      }
      friendly-snippets

      ###########################
      ## Lsp
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-lspconfig.lua;
      }
      {
        plugin = fidget-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/fidget-nvim.lua;
        optional = true;
      }

      #######################
      ##  Outline
      {
        plugin = outline-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/outline.lua;
        optional = true;
      }

      #######################
      ## fzf-lua
      {
        plugin = fzf-lua;
        type = "lua";
        config = builtins.readFile ./plugins/fzf-lua.lua;
        optional = true;
      }

      ########################
      ## Treesitter
      {
        plugin = nvim-treesitter.withPlugins (
          plugins: with plugins; [
            asm
            typescript
            tsx
            go
            rust
            c
            yaml
            lua
            vim
            vimdoc
            vue
            json
            html
            markdown
            markdown_inline
            toml
            regex
            nix
            nu
          ]
        );
        type = "lua";
        config = builtins.readFile ./plugins/nvim-treesitter.lua;
      }
      # {
      #   plugin = nvim-ts-autotag;
      #   type = "lua";
      #   config = builtins.readFile ./plugins/nvim-ts-autotag.lua;
      #   optional = true;
      # }

      ########################
      ## Statusline
      {
        # BUG: home-manager switch error
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "lualine.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-lualine";
            repo = "lualine.nvim";
            rev = "47f91c416daef12db467145e16bed5bbfe00add8";
            hash = "sha256-OpLZH+sL5cj2rcP5/T+jDOnuxd1QWLHCt2RzloffZOA=";
          };
        };
        type = "lua";
        config = builtins.readFile ./plugins/lualine.lua;
        # optional = true;
      }

      #########################
      ## Bufferline
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/bufferline.lua;
        optional = true;
      }

      ########################
      ## Commandline
      {
        plugin = noice-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/noice.lua;
      }

      #########################
      ## todo
      {
        plugin = todo-comments-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/todo-comments.lua;
        optional = true;
      }

      #########################
      ## Startup screen
      {
        plugin = alpha-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/alpha-nvim.lua;
        optional = true;
      }

      #########################
      ## Operator
      {
        plugin = substitute-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/substitute.lua;
        optional = true;
      }
      {
        plugin = nvim-surround;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-surround.lua;
        optional = true;
      }

      ########################
      ## Move
      {
        plugin = leap-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/leap.lua;
        optional = true;
      }

      #########################
      ## Move Block
      {
        plugin = move-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/move.lua;
      }

      ########################
      ## Join
      {
        plugin = treesj;
        type = "lua";
        config = builtins.readFile ./plugins/treesj.lua;
        optional = true;
      }

      #########################
      ## Adding
      {
        plugin = dial-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/dial.lua;
        optional = true;
      }

      #########################
      ## Grep
      {
        plugin = grug-far-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/grug-far.lua;
        optional = true;
      }

      #########################
      ## Search
      {
        plugin = nvim-hlslens;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-hlslens.lua;
        optional = true;
      }

      #########################
      ## Filer
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/neo-tree.lua;
        optional = true;
      }

      #########################
      ## Quickfix
      {
        plugin = nvim-bqf;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-bqf.lua;
        optional = true;
      }
      {
        plugin = quicker-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/quicker-nvim.lua;
        optional = true;
      }

      #########################
      ## Manual
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/which-key.lua;
        optional = true;
      }

      #########################
      ## Terminal

      #########################
      ## Git
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/gitsigns.lua;
        optional = true;
      }
      ## TODO: lz-n適用とoptional設定(実際にコンフリクト起きてからでいい)
      {
        plugin = git-conflict-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/git-conflict.lua;
      }
      {
        plugin = diffview-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/diffview.lua;
        optional = true;
      }

      #########################
      ## Formatter
      {
        plugin = conform-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/conform.lua;
        optional = true;
      }

      ########################
      ## Linter
      {
        plugin = nvim-lint;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-lint.lua;
        optional = true;
      }

      ########################
      ## Reading assistant
      ## snacks-nvim

      #########################
      ## Brackets
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-autopairs.lua;
        optional = true;
      }

      ############################
      ## Memo

      #################################
      ## Language

      ## Rust
      {
        plugin = crates-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/crates.lua;
        optional = true;
      }

      ## markdown
      {
        plugin = render-markdown-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/render-markdown.lua;
        optional = true;
      }

      ## json yaml
      {
        plugin = SchemaStore-nvim;
        optional = true;
      }
    ];

    extraPackages = with pkgs; [
      # Bash
      nodePackages.bash-language-server
      shellcheck
      shfmt

      # grammer
      vale

      # Nix
      nixd
      nixfmt-rfc-style

      # Lua
      stylua
      lua-language-server

      # TypeScript
      typescript-language-server

      # json
      nodePackages.vscode-json-languageserver

      # yaml
      yaml-language-server
      yamllint

      # TOML
      taplo

      # etc
      biome
      prettierd

      # fzf-lua
      ripgrep
      fd
      fzf
    ];

    extraLuaConfig = ''
      		${builtins.readFile ./core/base.lua}
      		${builtins.readFile ./core/option.lua}
      		${builtins.readFile ./core/display.lua}
      		${builtins.readFile ./core/mappings.lua}
      		${builtins.readFile ./core/command.lua}
      		${builtins.readFile ./core/autocmd.lua}
    '';
  };
}
