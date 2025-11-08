require("lz.n").load({
	"snacks.nvim",
	lazy = false,
	after = function()
		require("snacks").setup({
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			explorer = { enabled = false },
			indent = {
				enabled = true,
				only_scope = false,
				only_current = false,
				animate = {
					enabled = false,
				},
				scope = {
					enabled = true, -- enable highlighting the current scope
					priority = 200,
					char = "│",
					underline = false, -- underline the start of the scope
					only_current = false, -- only show scope in the current window
					hl = "SnacksIndent4", ---@type string|string[] hl group for scopes
				},
			},
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		})
	end,
})
