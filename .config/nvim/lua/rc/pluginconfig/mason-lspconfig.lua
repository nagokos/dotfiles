require("mason-lspconfig").setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

	-- vim.lsp.inlay_hint.enable(true)

	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.keymap.set('n', "[_Lsp]rn", '<cmd>lua vim.lsp.buf.rename()<CR>')
	vim.keymap.set("n", "[_Lsp]d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.keymap.set("n", "[_Lsp]rf", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.keymap.set("n", "?", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
end

require('lspconfig.ui.windows').default_options = {
	border = "rounded"
}
vim.diagnostic.config {
	virtual_text = {
		prefix = "●",
	},
	float = {
		border = "rounded",
	},
}

local group_name = "vimrc_mason_lspconfig"
vim.api.nvim_create_augroup(group_name, { clear = true })
local lspconfig = require("lspconfig")
local capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities()
)
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
	["rust_analyzer"] = function()
		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				check = {
					command = "clippy"
				}
			}
		})
	end,
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					-- hint = { enable = true },
					format = {
						enable = true,
						defaultConfig = {
							indent_style = "tab",
							indent_size = "2",
						},
					},
				},
			},
		})
	end,
})
