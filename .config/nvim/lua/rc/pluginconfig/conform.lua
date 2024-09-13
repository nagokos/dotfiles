require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2" },
		},
	},
	formatters_by_ft = {
		rust = { "rustfmt", lsp_format = "fallback" },
		lua = { "stylua" },
		nix = { "nixpkgs-fmt" },
	}
})
