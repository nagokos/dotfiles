require("lz.n").load({
	"bufferline.nvim",
	event = "DeferredUIEnter",
	after = function()
		vim.cmd.highlight("TabLineSel guibg=#ddc7a1")

		require("bufferline").setup({
			options = {
				numbers = function(opts)
					return string.format("%s.%s", opts.ordinal, opts.lower(opts.id))
				end,
				diagnostics = "nvim_lsp",

				-- selene: allow(unused_variable)
				---@diagnostic disable-next-line: unused-local
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					return "(" .. count .. ")"
				end,
				custom_filter = function(buf_number)
					-- filter out filetypes you don't want to see
					if vim.bo[buf_number].filetype == "qf" then
						return false
					end
					if vim.bo[buf_number].buftype == "terminal" then
						return false
					end
					-- -- filter out by buffer name
					if
						vim.api.nvim_buf_get_name(buf_number) == ""
						or vim.api.nvim_buf_get_name(buf_number) == "[No Name]"
					then
						return false
					end
					if vim.api.nvim_buf_get_name(buf_number) == "[dap-repl]" then
						return false
					end
					return true
				end,
				show_buffer_close_icons = false,
				show_close_icon = false,
				enforce_regular_tabs = true,
				sort_by = function(buffer_a, buffer_b)
					if not buffer_a and buffer_b then
						return true
					elseif buffer_a and not buffer_b then
						return false
					end
					return buffer_a.ordinal < buffer_b.ordinal
				end,
			},
		})
		vim.keymap.set("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "L", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
	end,
})
