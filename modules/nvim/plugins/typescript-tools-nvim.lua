require("lz.n").load({
	"typescript-tools.nvim",
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	keys = {
		{ "[_Lsp]ta", "<Cmd>TSToolsRemoveUnused<CR>", desc = "removes all unused statements" },
	},
	after = function()
		require("typescript-tools").setup({
			settings = {
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeCompletionsForModuleExports = true,
					quotePreference = "auto",
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				vim.keymap.set("n", "?", vim.lsp.buf.hover, opts)

				vim.keymap.set("n", "[_Lsp]e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				vim.keymap.set("n", "[_Lsp]d", vim.lsp.buf.definition, opts)

				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			end,
		})
	end,
})
