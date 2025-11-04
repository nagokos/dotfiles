require("lz.n").load({
	"fzf-lua",
	cmd = { "FzfLua" },
	keys = {
		{ "[_FuzzyFinder]f", "<Cmd>FzfLua files<CR>", desc = "files" },
		{ "[_FuzzyFinder]r", "<Cmd>FzfLua resume<CR>", desc = "resume" },
		{ "[_FuzzyFinder]o", "<Cmd>FzfLua oldfiles<CR>", desc = "old files" },
		{ "[_FuzzyFinder]ss", "<Cmd>FzfLua live_grep<CR>", desc = "live grep" },
		{ "[_FuzzyFinder]sg", "<Cmd>FzfLua live_grep_glob<CR>", desc = "live grep glob" },
		{ "[_FuzzyFinder]c", "<Cmd>FzfLua commands<CR>", desc = "commands" },
		{ "[_FuzzyFinder]q", "<Cmd>FzfLua quickfix<CR>", desc = "quickfix" },
		{ "[_FuzzyFinder]l", "<Cmd>FzfLua loclist<CR>", desc = "loclist" },
		{ "[_FuzzyFinder]'", "<Cmd>FzfLua marks<CR>", desc = "marks" },
		{ "[_FuzzyFinder]y", "<Cmd>FzfLua registers<CR>", desc = "registers" },
		{ "[_FuzzyFinder]w", "<Cmd>FzfLua grep_cword<CR>", desc = "grep cursor word" },
		{ "[_FuzzyFinder]d", "<Cmd>FzfLua diagnostics_workspace<CR>", desc = "diagnostics workspace" },
		{ "[_FuzzyFinder]t", "<Cmd>TodoFzfLua<CR>", desc = "todo" },

		{ "[_FuzzyFinder]gf", "<Cmd>FzfLua git_files<CR>", desc = "git files" },
		{ "[_FuzzyFinder]gs", "<Cmd>FzfLua git_status<CR>", desc = "git status" },
		{ "[_FuzzyFinder]gc", "<Cmd>FzfLua git_commits<CR>", desc = "git commits" },
		{ "[_FuzzyFinder]gb", "<Cmd>FzfLua git_branches<CR>", desc = "git branches" },
	},
	after = function()
		local fzf = require("fzf-lua")
		local actions = require("fzf-lua.actions")

		local custom_file_sel_to_qf = function(selected, opts)
			local qf_list = {}
			for i = 1, #selected do
				local file = require("fzf-lua.path").entry_to_file(selected[i], opts)
				local text = file.stripped:match(":%d+:%d?%d?%d?%d?:?(.*)$")
				table.insert(qf_list, {
					bufnr = file.bufnr,
					filename = file.bufname or file.path or file.uri,
					lnum = file.line,
					col = file.col,
					text = text,
				})
			end

			local title = string.format(
				"[FzfLua] %s%s",
				opts.__INFO and opts.__INFO.cmd .. ": " or "",
				require("fzf-lua.utils").resume_get("query", opts) or ""
			)

			vim.fn.setqflist({}, " ", {
				nr = "$",
				items = qf_list,
				title = title,
			})
		end

		fzf.setup({
			winopts = {
				height = 0.85, -- window height
				width = 0.80, -- window width
				row = 0.35, -- window row position (0=top, 1=bottom)
				col = 0.50, -- window col position (0=left, 1=right)
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				backdrop = 100,
				fullscreen = false, -- start fullscreen?
				preview = {
					border = "border", -- border|noborder, applies only to
					wrap = "nowrap", -- wrap|nowrap
					hidden = "nohidden", -- hidden|nohidden
					vertical = "down:45%", -- up|down:size
					horizontal = "right:60%", -- right|left:size
					layout = "flex", -- horizontal|vertical|flex
					flip_columns = 120, -- #cols to switch to horizontal on flex
					title = true, -- preview border title (file/buf)?
					title_pos = "center", -- left|center|right, title alignment
					scrollbar = "float", -- `false` or string:"float|border"
					scrolloff = "-2", -- float scrollbar offset from right
					scrollchars = { "█", "" }, -- scrollbar chars ({ <full>, <empty> }
					delay = 100, -- delay(ms) displaying the preview
					winopts = { -- builtin previewer window options
						number = true,
						relativenumber = false,
						cursorline = true,
						cursorlineopt = "both",
						cursorcolumn = false,
						signcolumn = "no",
						list = false,
						foldenable = false,
						foldmethod = "manual",
					},
				},
			},
			keymap = {
				builtin = {
					false, -- do not inherit from defaults
					["<C-c>"] = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
					["<F1>"] = "toggle-help",
					["<C-h>"] = "toggle-fullscreen",
					["<C-d>"] = "preview-page-down",
					["<C-u>"] = "preview-page-up",
				},
				fzf = {
					false, -- do not inherit from defaults
					["ctrl-j"] = "",
					["ctrl-k"] = "",
					["ctrl-c"] = "abort",
					["ctrl-w"] = "unix-line-discard",
					["ctrl-a"] = "beginning-of-line",
					["ctrl-e"] = "end-of-line",
					["ctrl-f"] = "half-page-down",
					["ctrl-b"] = "half-page-up",
					["ctrl-o"] = "toggle-all",
				},
			},
			actions = {
				files = {
					false, -- do not inherit from defaults
					["enter"] = actions.file_edit,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-q"] = { fn = custom_file_sel_to_qf, reload = false },
				},
			},
			defaults = {
				prompt = "> ",
			},
			files = {
				input_prompt = "> ",
				multiprocess = true, -- run command in a separate process
				git_icons = true, -- show git icons?
				file_icons = true, -- show file icons (true|"devicons"|"mini")?
				color_icons = true, -- colorize file|git icons
				find_opts = [[-type f -not -path "*/\.git/*" -printf "%P\n"]],
				rg_opts = [[--color=never --files --hidden --follow -g "!.git"]],
				fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
				cwd_prompt = true,
				cwd_prompt_shorten_len = 32, -- shorten prompt beyond this length
				cwd_prompt_shorten_val = 1, -- shortened path parts length
				toggle_ignore_flag = "--no-ignore", -- flag toggled in `actions.toggle_ignore`
				toggle_hidden_flag = "--hidden", -- flag toggled in `actions.toggle_hidden`
				actions = {
					["ctrl-g"] = { actions.toggle_ignore },
				},
			},
			git = {
				files = {
					cmd = "git ls-files --exclude-standard",
					multiprocess = true, -- run command in a separate process
					git_icons = true, -- show git icons?
					file_icons = true, -- show file icons (true|"devicons"|"mini")?
					color_icons = true, -- colorize file|git icons
				},
				status = {
					cmd = "git -c color.status=false --no-optional-locks status --porcelain=v1 -u",
					multiprocess = true, -- run command in a separate process
					file_icons = true,
					git_icons = true,
					color_icons = true,
					previewer = "git_diff",
					actions = {
						["right"] = { fn = actions.git_unstage, reload = true },
						["left"] = { fn = actions.git_stage, reload = true },
						["ctrl-x"] = { fn = actions.git_reset, reload = true },
					},
				},
				commits = {
					prompt = "> ",
					cmd = [[git log --color --pretty=format:"%C(yellow)%h%Creset ]]
						.. [[%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset"]],
					preview = "git show --color {1}",
					actions = {
						["enter"] = actions.git_checkout,
						["ctrl-y"] = { fn = actions.git_yank_commit, exec_silent = true },
					},
				},
				branches = {
					prompt = "> ",
					cmd = "git branch --all --color",
					preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
					actions = {
						["enter"] = actions.git_switch,
						["ctrl-x"] = { fn = actions.git_branch_del, reload = true },
						["ctrl-a"] = { fn = actions.git_branch_add, field_index = "{q}", reload = true },
					},
					cmd_add = { "git", "branch" },
					cmd_del = { "git", "branch", "--delete" },
				},
				icons = {
					["M"] = { icon = "M", color = "yellow" },
					["D"] = { icon = "D", color = "red" },
					["A"] = { icon = "A", color = "green" },
					["R"] = { icon = "R", color = "yellow" },
					["C"] = { icon = "C", color = "yellow" },
					["T"] = { icon = "T", color = "magenta" },
					["?"] = { icon = "?", color = "magenta" },
				},
			},
			grep = {
				input_prompt = "> ",
				multiprocess = true, -- run command in a separate process
				git_icons = true, -- show git icons?
				file_icons = true, -- show file icons (true|"devicons"|"mini")?
				color_icons = true, -- colorize file|git icons
				grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
				rg_glob = false, -- default to glob parsing?
				glob_flag = "--iglob", -- for case sensitive globs use "--glob"
				glob_separator = "%s%-%-", -- query separator pattern (lua): " --"
				actions = {
					["ctrl-g"] = { actions.grep_lgrep },
				},
				no_header = false, -- hide grep|cwd header?
				no_header_i = false, -- hide interactive header?
			},
			oldfiles = {
				cwd_only = true,
				stat_file = true, -- verify files exist on disk
				include_current_session = false, -- include bufs from current session
			},
			quickfix = {
				file_icons = true,
				git_icons = true,
				only_valid = false, -- select among only the valid quickfix entries
			},
			loclist = {
				file_icons = true,
				git_icons = true,
				only_valid = false, -- select among only the valid quickfix entries
			},
			diagnostics = {
				cwd_only = true,
				file_icons = true,
				git_icons = false,
				diag_icons = true,
				diag_source = true, -- display diag source (e.g. [pycodestyle])
				icon_padding = "", -- add padding for wide diagnostics signs
				multiline = true, -- concatenate multi-line diags into a single line
			},
			marks = {
				marks = "", -- filter vim marks with a lua pattern
			},
			file_icon_padding = "",
		})
	end,
})
