require("lz.n").load({
	"rustaceanvim",
	ft = "rust",
	after = function()
		vim.g.rustaceanvim = {
			server = {
				on_attach = function(_, bufnr)
					local opts = { silent = true, buffer = bufnr }
					vim.keymap.set("n", "[_Lsp]rr", function()
						vim.cmd.RustLsp("runnables")
					end, vim.tbl_extend("force", opts, { desc = "Rust runnables" }))
					vim.keymap.set("n", "[_Lsp]rt", function()
						vim.cmd.RustLsp("testables")
					end, vim.tbl_extend("force", opts, { desc = "Rust testables" }))
					vim.keymap.set("n", "[_Lsp]rc", function()
						vim.cmd.RustLsp("openCargo")
					end, vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" }))
					vim.keymap.set("n", "[_Lsp]rp", function()
						vim.cmd.RustLsp("parentModule")
					end, vim.tbl_extend("force", opts, { desc = "Parent module" }))
				end,
				default_settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = { command = "clippy" },
					},
				},
			},
			-- dap = {
			-- 	adapter = {
			-- 		type = "executable",
			-- 		command = "lldb-dap",
			-- 		name = "rt_lldb",
			-- 	},
			-- },
		}
	end,
})
