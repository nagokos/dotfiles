require("lz.n").load({
	"conform.nvim",
	event = "BufWritePost",
	keys = {
		{
			"[_Lsp]f",
			function()
				require("conform").format({
					timeout_ms = 500,
					lsp_format = "fallback",
					stop_after_first = true,
				})
			end,
			desc = "Format buffer",
		},
	},
	after = function()
		local web_formatter = { "biome", "prettierd", stop_after_first = true }
		require("conform").setup({
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				bash = { "shfmt" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				json = web_formatter,
				yaml = web_formatter,
				typescript = web_formatter,
				javascript = web_formatter,
				typescriptreact = web_formatter,
				javascriptreact = web_formatter,
				nix = { "nixfmt" },
			},
		})
	end,
})
