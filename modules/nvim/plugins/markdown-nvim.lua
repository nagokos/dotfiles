require("lz.n").load({
	"markdown.nvim",
	ft = "markdown",
	after = function()
		local function is_list_item()
			local md_ts = require("markdown.treesitter")
			local curr_row = vim.api.nvim_win_get_cursor(0)[1] - 1
			local curr_eol = vim.fn.col("$") - 1

			return md_ts.find_node(function(node)
				return node:type() == "list_item"
			end, { pos = { curr_row, curr_eol } })
		end

		require("markdown").setup({
			on_attach = function(bufnr)
				-- New list item below on `o` if in a list
				vim.keymap.set("n", "o", function()
					if is_list_item() then
						vim.cmd("MDListItemBelow")
						return
					end

					vim.api.nvim_feedkeys("o", "n", true)
				end, { buffer = bufnr, desc = "Insert list item below" })

				-- New list item above on `O` if in a list
				vim.keymap.set("n", "O", function()
					if is_list_item() then
						vim.cmd("MDListItemAbove")
						return
					end

					vim.api.nvim_feedkeys("O", "n", true)
				end, { buffer = bufnr, desc = "Insert list item above" })

				-- New list item below on `<cr>` if in a list and at the end of the line
				vim.keymap.set("i", "<cr>", function()
					local is_eol = vim.fn.col(".") == vim.fn.col("$")
					local in_list = is_list_item()

					if is_eol and in_list then
						vim.cmd("MDListItemBelow")
						return
					end

					local key = vim.api.nvim_replace_termcodes("<cr>", true, false, true)
					vim.api.nvim_feedkeys(key, "n", false)
				end, { buffer = bufnr, desc = "Insert list item below" })
			end,
		})
	end,
})
