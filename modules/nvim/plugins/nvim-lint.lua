require("lz.n").load({
	"nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		require("lint").linters_by_ft = {
			-- markdown = { "vale" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },
			yaml = { "yamllint" },
			-- project specific overrrides .nvim.lua
			-- javascript = {'biomejs',},
			-- typescript = {'biomejs',},
			-- typescriptreact = {'biomejs'},
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
})
