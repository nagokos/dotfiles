require("lz.n").load({
	"dial.nvim",
	event = "DeferredUIEnter",
	after = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			-- default augends used when no group name is specified
			default = {
				augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
				augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
				augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
				augend.constant.alias.bool, -- boolean value (true <-> false)
				augend.case.new({
					types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
					cyclic = true,
				}),
			},
			case = {
				augend.case.new({
					types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" },
					cyclic = true,
				}),
			},
		})

		vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { silent = true, noremap = true })
		vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { silent = true, noremap = true })
		vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { silent = true, noremap = true })
		vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { silent = true, noremap = true })
	end,
})
