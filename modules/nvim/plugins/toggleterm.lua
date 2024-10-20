require("lz.n").load({
	"toggleterm.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("toggleterm").setup({
			-- size can be a number or function which is passed the current terminal
			size = function(term)
				if term.direction == "horizontal" then
					return vim.o.lines * 0.25
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-z>]],
			hide_numbers = true, -- hide the number column in toggleterm buffers
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
			start_in_insert = true,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			persist_size = false,
			direction = "float",
			close_on_exit = false, -- close the terminal window when the process exits
			shell = vim.o.shell, -- change the default shell
			-- This field is only relevant if direction is set to 'float'
			float_opts = {
				border = "curved",
				width = math.floor(vim.o.columns * 0.9),
				height = math.floor(vim.o.lines * 0.9),
				winblend = 3,
				highlights = { border = "ColorColumn", background = "ColorColumn" },
			},
		})

		vim.api.nvim_set_keymap(
			"n",
			"<C-z>",
			'<Cmd>execute v:count1 . "ToggleTerm"<CR>',
			{ noremap = true, silent = true }
		)

		local groupname = "vimrc_toggleterm"
		vim.api.nvim_create_augroup(groupname, { clear = true })
		vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter", "BufEnter" }, {
			group = groupname,
			pattern = "term://*#toggleterm#*", -- パターンを変更して全てのtoggletermに適用
			callback = function()
				vim.schedule(function()
					if vim.bo.buftype == "terminal" then
						vim.cmd.startinsert()
					end
				end)
			end,
			once = false,
		})

		-- <Esc>キーのマッピングを設定するオートコマンド
		vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
			group = groupname,
			pattern = "term://*#toggleterm#*", -- パターンを変更して全てのtoggletermに適用
			callback = function()
				vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, buffer = true })
				vim.keymap.set(
					"n",
					"<Esc>",
					"<Cmd>exe 'ToggleTerm'<CR>",
					{ noremap = true, silent = true, buffer = true }
				)
				vim.keymap.set("n", "i", "<Cmd>startinsert<CR>", { noremap = true, silent = true, buffer = true })
			end,
			once = false,
		})
	end,
})
