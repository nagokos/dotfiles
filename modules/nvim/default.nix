{ inputs, pkgs, ... }:
let
  # indent
  hlchunk-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "hlchunk.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "shellRaining";
      repo = "hlchunk.nvim";
      rev = "6c25dbc174d6bdecee6cbeab1d7a783fd2c407ba";
      sha256 = "0vwiq3337isca1p6qpg3gas21hlcsfhbs1i6386k05hmadvyijbz";
    };
  };

  # Treesitter
  nvim-treehopper = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-treehopper";
    src = pkgs.fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-treehopper";
      rev = "13559079e33665a310d9ccf0e43f4e9bb9f337e2";
      sha256 = "0xs1fv1j4b4jnrddwcgbzm5d3gg3b47xm1kzrhsxj6366zrrvlpg";
    };
  };
  treesitter-unit = pkgs.vimUtils.buildVimPlugin {
    name = "treesitter-unit";
    src = pkgs.fetchFromGitHub {
      owner = "David-Kunz";
      repo = "treesitter-unit";
      rev = "89968a1f8c72427691088e6d09d26a52c2ddc6f4";
      sha256 = "1jc2pcd0lg78a37yd2lcp4yghpcz28a4rmcm8qdi63mc9npil4ka";
    };
  };

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

  # quickfix
  quicker-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "quicker.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "stevearc";
      repo = "quicker.nvim";
      rev = "46e0ad6c6a1d998a294e13cbb8b7c398e140983a";
      hash = "sha256-rlKI23VZ8TzGRvl7C6wu83VpSdkzdHliElUZD+8U0iE=";
    };
  };

  # markdown
  markdown-table-mode-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "markdown-table-mode.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Kicamon";
      repo = "markdown-table-mode.nvim";
      rev = "870d0449c1c78c673faa9637a63036f9537b4caa";
      hash = "sha256-msg0bZYyDfQKAb+a7TZUWj/HiFCFvHvZDXixzEXEu2o=";
    };
  };

  # nu
  tree-sitter-nu = pkgs.callPackage ./plugins/nvim-treesitter-nu.nix {
    inherit (pkgs.tree-sitter) buildGrammar;
  };
in
{
  home.packages = with pkgs; [
    vim-startuptime
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
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
          vim.cmd.colorscheme("nordfox")
        '';
      }

      ####################
      ## Font 
      nvim-web-devicons

      #####################
      ## UI Library
      {
        plugin = dressing-nvim;
        type = "lua";
        config = ''
          require("dressing").setup({})
        '';
      }

      #####################
      ## Notify
      {
        plugin = nvim-notify;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-notify.lua;
        optional = true;
      }

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

            tree-sitter-nu.grammar
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
      {
        plugin = nvim-treehopper;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-treehopper.lua;
      }
      {
        plugin = treesitter-unit;
        type = "lua";
        config = builtins.readFile ./plugins/treesitter-unit.lua;
      }

      ########################
      ## Statusline
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/lualine.lua;
        optional = true;
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
        optional = true;
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
      # {
      #   plugin = toggleterm-nvim;
      #   type = "lua";
      #   config = builtins.readFile ./plugins/toggleterm.lua;
      #   optional = true;
      # }

      #########################
      ## Git
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/gitsigns.lua;
        optional = true;
      }
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
      {
        plugin = hlchunk-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/hlchunk.lua;
      }

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
      {
        plugin = obsidian-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/obsidian.lua;
        optional = true;
      }

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
        plugin = markview-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/markview.lua;
        optional = true;
      }
      {
        plugin = markdown-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/markdown-nvim.lua;
        optional = true;
      }
      {
        plugin = markdown-table-mode-nvim;
        type = "lua";
        config = ''
          require("markdown-table-mode").setup({})
        '';
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
      nil
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

  xdg.configFile = {
    "nvim/queries/nu/highlights.scm".text = tree-sitter-nu.highlights;
    "nvim/queries/nu/injections.scm".text = tree-sitter-nu.injections;
  };
}
