require("lz.n").load({
	"obsidian.nvim",
	cmd = "Obsidian",
	ft = "markdown",
	keys = {
		{ "[_FuzzyFinder]mn", "<Cmd>Obsidian new<CR>", desc = "obsidian open" },
		{ "[_FuzzyFinder]ms", "<Cmd>Obsidian search<CR>", desc = "obsidian search" },
		{ "[_FuzzyFinder]mq", "<Cmd>Obsidian quick_switch<CR>", desc = "obsidian quick switch" },
		{ "[_FuzzyFinder]mt", "<Cmd>Obsidian tags<CR>", desc = "obsidian tags" },
		{ "[_FuzzyFinder]mw", "<Cmd>Obsidian workspace<CR>", desc = "obsidian switch workspace" },
		{ "[_FuzzyFinder]m1", "<Cmd>Obsidian today<CR>", desc = "obsidian switch workspace" },
		{ "[_FuzzyFinder]m2", "<Cmd>Obsidian tomorrow<CR>", desc = "obsidian switch workspace" },
	},
	after = function()
		require("lz.n").trigger_load("fzf-lua")

		vim.opt.conceallevel = 1

		require("obsidian").setup({
			legacy_commands = false,
			workspaces = {
				{
					name = "memo",
					path = "/Users/kosudanaohiro/memo",
				},
			},

			note_id_func = function(title)
				local purified
				if title then
					-- UTF-8対応: 一旦小文字化
					purified = title:lower()

					-- 英数字・アンダースコア・ハイフン以外をハイフンに置き換え
					-- （UTF-8安全に行うため pattern.match を使わず gsub でバイト単位処理）
					purified = purified:gsub("[^%w%-_]", "-")

					-- ハイフンを整理
					purified = purified:gsub("^-+", ""):gsub("-+$", ""):gsub("-+", "-")

					-- 全部ハイフンや空なら無効扱い
					if purified == "" or purified:match("^-*$") then
						purified = nil
					end
				end

				-- fallback: ランダム英大文字4文字
				if not purified then
					purified = ""
					for _ = 1, 4 do
						purified = purified .. string.char(math.random(65, 90))
					end
				end

				return os.date("%Y%m%d-%H%M%S-") .. purified
			end,
			note_path_func = function(spec)
				local path
				local filename = spec.title
				if filename then
					filename = vim.fn.substitute(filename, [=[[ \%u3000]]=], "-", "g")
					filename = vim.fn.substitute(filename, [=[['"\\/:]]=], "", "g")
					filename = filename:lower()
					path = spec.dir / (os.date("%Y%m%d-%H%M%S-") .. filename)
				else
					path = spec.dir / spec.id
				end
				return path:with_suffix(".md")
			end,
			attachments = {
				---@return string
				image_name_func = function()
					return tostring(os.date("%Y%m%d-%H%M%S-"))
				end,
			},
			picker = {
				name = "fzf-lua",
				note_mappings = {
					-- Create a new note from your query.
					new = "<C-x>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
				tag_mappings = {
					-- Add tag(s) to current note.
					tag_note = "<C-x>",
					-- Insert a tag at the current location.
					insert_tag = "<C-l>",
				},
			},
		})
	end,
})
