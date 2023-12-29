local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	}, { text = true }):wait()
end
vim.opt.runtimepath:prepend(lazypath)

local plugins = {

	-------------------------------------------------------------
	-- Installer
	{ "folke/lazy.nvim" },

	-- External package Installer
	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "VimEnter" },
		build = ":MasonUpdate",
		config = function()
			require("rc/pluginconfig/mason")
		end,
	},

	--------------------------------
	-- Lua Library
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "kkharji/sqlite.lua" },
	{ "MunifTanjim/nui.nvim" },

	--------------------------------
	-- UI Library
	{
		"stevearc/dressing.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/dressing")
		end,
	},

	--------------------------------
	-- Notify
	{
		"rcarriga/nvim-notify",
		event = "BufReadPre",
		config = function()
			require("rc/pluginconfig/nvim-notify")
		end,
	},

	--------------------------------
	-- ColorScheme
	{
		"rebelot/kanagawa.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig//kanagawa")
		end,
	},
	--------------------------------

	-- Font
	{
		"kyazdani42/nvim-web-devicons",
	},

	--------------------------------------------------------------
	-- LSP & completion

	--------------------------------
	-- Auto Completion
	{
		"hrsh7th/nvim-cmp",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-cmp")
		end,
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-calc" },
			{ "f3fora/cmp-spell" },
			{
				"uga-rosa/cmp-dictionary",
				config = function()
					require("rc/pluginconfig/cmp-dictionary")
				end,
			},
			{ "rafamadriz/friendly-snippets" },
			{ "ray-x/cmp-treesitter" },
			{
				"onsails/lspkind-nvim",
				config = function()
					require("rc/pluginconfig/lspkind-nvim")
				end,
			},
		},
	},

	--------------------------------
	-- Language Server Protocol(LSP)
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("rc/pluginconfig/nvim-lspconfig")
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		config = function()
			require("rc/pluginconfig/mason-lspconfig")
		end,
		dependencies = {
			{
				"folke/neodev.nvim",
				config = function()
					require("rc/pluginconfig/neodev")
				end,
			},
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("rc/pluginconfig/lsp_signature")
		end,
	},

	--------------------------------
	-- LSP's UI
	{
		"nvimdev/lspsaga.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/lspsaga")
		end,
	},
	{
		"folke/trouble.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/trouble")
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/fidget")
		end,
	},

	------------------------------
	-- telescope.nvim
	{
		"nvim-telescope/telescope.nvim",
		event = { "VimEnter" },
		config = function()
			require("rc/pluginconfig/telescope")
		end,
		dependencies = {
			{
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					require("telescope").load_extension("ui-select")
				end,
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				config = function()
					require("telescope").load_extension("live_grep_args")
				end,
			},
		},
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		event = "VeryLazy",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},
	-- Consider telescope-improt

	--------------------------------
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost" },
		build = ":TSUpdateSync",
		config = function()
			require("rc/pluginconfig/nvim-treesitter")
		end,
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "yioneko/nvim-yati" },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
	},
	{
		"mizlan/iswap.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/iswap")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"mfussenegger/nvim-treehopper",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-treehopper")
		end,
	},
	{
		"David-Kunz/treesitter-unit",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/treesitter-unit")
		end,
	},

	--------------------------------
	-- Treesitter UI customize
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		config = function()
			-- patch https://github.com/nvim-treesitter/nvim-treesitter/issues/1124
			vim.cmd.edit({ bang = true })
		end,
	},
	{
		"romgrk/nvim-treesitter-context",
		cmd = { "TSContextEnable" },
		event = "VeryLazy",
		config = function()
			require("treesitter-context").setup()
		end,
	},

	--------------------------------
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/lualine")
		end,
	},

	--------------------------------
	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VimEnter",
		enabled = function()
			return not vim.g.vscode
		end,
		config = function()
			require("rc/pluginconfig/bufferline")
		end,
	},

	--------------------------------
	-- Commandline
	{
		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/noice")
		end,
	},
	{
		"hrsh7th/cmp-cmdline",
		event = "VimEnter",
	},

	----------------------------
	-- Comment
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/Comment")
		end,
	},

	--------------------------------
	-- Highlight
	{
		"xiyaowong/nvim-cursorword",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-cursorword")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/todo-comments")
		end,
	},

	--------------------------------
	-- Startup screen
	{
		"goolord/alpha-nvim",
		event = "BufEnter",
		config = function()
			require("rc/pluginconfig/alpha-nvim")
		end,
	},

	--------------------------------
	-- Scrollbar
	{
		"petertriho/nvim-scrollbar",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-scrollbar")
		end,
		dependencies = { { "kevinhwang91/nvim-hlslens" } },
	},

	--------------------------------
	-- Operator
	{
		"gbprod/substitute.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/substitute")
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-surround")
		end,
	},

	-------------------------------------
	-- Join
	{
		"Wansmer/treesj",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/treesj")
		end,
	},

	-----------------
	-- Adding and subtracting
	{
		"monaqa/dial.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/dial")
		end,
	},

	--------------------------------
	-- Yank
	{
		"hrsh7th/nvim-pasta",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-pasta")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-neoclip")
		end,
	},

	--------------------------------
	-- Find
	{
		"kevinhwang91/nvim-hlslens",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-hlslens")
		end,
	},
	{
		"rapan931/lasterisk.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/lasterisk")
		end,
	},

	--------------------------------
	-- Grep tool
	{
		"windwp/nvim-spectre",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-spectre")
		end,
	},

	--------------------------------
	-- Filer
	{
		"nvim-neo-tree/neo-tree.nvim",
		event = "VimEnter",
		branch = "main",
		config = function()
			require("rc/pluginconfig/neo-tree")
		end,
	},

	--------------------------------------
	-- Move
	-- {
	-- 	"ggandor/leap.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("leap").add_default_mappings()
	-- 	end,
	-- },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/flash")
		end,
	},

	-- Move Block
	{
		"fedepujol/move.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/move")
		end,
	},

	--------------------------------
	-- Quickfix
	{
		"kevinhwang91/nvim-bqf",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-bqf")
		end,
	},
	{
		"gabrielpoca/replacer.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/replacer")
		end,
	},
	{
		"stevearc/qf_helper.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/qf_helper")
		end,
	},

	--------------------------------
	-- Session
	-- do not use the session per current directory
	{
		"jedrzejboczar/possession.nvim",
		-- lazy = false,
		event = "BufEnter",
		config = function()
			require("rc/pluginconfig/possession")
		end,
	},

	------------------------------------
	-- command
	{
		"sQVe/sort.nvim",
		cmd = { "Sort" },
	},
	{
		"smjonas/live-command.nvim",
		event = "CmdlineEnter",
		config = function()
			require("rc/pluginconfig/live-command")
		end,
	},
	{
		"jghauser/mkdir.nvim",
		event = "VeryLazy",
		config = function()
			require("mkdir")
		end,
	},

	--------------------------------
	-- Mark
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/marks")
		end,
	},

	--------------------------------
	-- Manual
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/which-key")
		end,
	},

	--------------------------------
	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/toggleterm")
		end,
	},

	--------------------------------
	-- Popup Info
	{
		"lewis6991/hover.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/hover")
		end,
	},

	--------------------------------
	-- Reading assistant
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/indent-blankline")
		end,
	},

	--------------------------------
	-- Brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"hrsh7th/nvim-insx",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-insx")
		end,
	},

	--------------------------------
	-- Test
	{
		"klen/nvim-test",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-test")
		end,
	},
	{
		"michaelb/sniprun",
		enabled = function()
			return vim.fn.executable("cargo")
		end,
		build = "bash install.sh",
		cmd = { "SnipRun" },
	},

	--------------------------------
	-- Task runner
	{
		"stevearc/overseer.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/overseer")
		end,
	},

	--------------------------------
	-- Lint
	-- {
	--   "mfussenegger/nvim-lint",
	--   event = "VimEnter",
	--   config = function()
	--     require("rc/pluginconfig/nvim-lint")
	--   end,
	-- },

	--------------------------------
	-- Format
	-- {
	--   "stevearc/conform.nvim",
	--   event = "VimEnter",
	--   config = function()
	--     require("rc/pluginconfig/conform")
	--   end,
	-- },
	--
	{
		"nvimtools/none-ls.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/null-ls")
		end,
	},

	--------------------------------
	-- Project
	-- {'ygm2/rooter.nvim', event = "VimEnter"}
	{
		"ahmedkhalf/project.nvim",
		event = "BufWinEnter",
		config = function()
			require("rc/pluginconfig/project")
		end,
	},

	----------------------------
	-- Git
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("rc/pluginconfig/neogit")
	-- 	end,
	-- },
	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/gitsigns")
		end,
	},
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/diffview")
		end,
	},

	------------------------------
	-- Debugger
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			require("rc/pluginconfig/nvim-dap")
		end,
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				config = function()
					require("rc/pluginconfig/nvim-dap-ui")
				end,
			},
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "nvim-telescope/telescope-dap.nvim" },
		},
	},

	----------------------------------
	---- Snippet
	{
		"L3MON4D3/LuaSnip",
		event = "VimEnter",
		build = "make install_jsregexp",
		config = function()
			require("rc/pluginconfig/LuaSnip")
		end,
	},

	----Snippet Pack
	{ "rafamadriz/friendly-snippets" },

	--------------------------------
	-- Rust
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- },
}

require("lazy").setup(plugins, {
	defaults = {
		lazy = true,
	},
})
