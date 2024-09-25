require("lz.n").load({
	"obsidian.nvim",
	ft = "markdown",
	keys = {
		{ "[_FuzzyFinder]mn", "<Cmd>ObsidianNew<CR>", desc = "obsidian open" },
		{ "[_FuzzyFinder]md", "<Cmd>ObsidianToday<CR>", desc = "obsidian today" },
		{ "[_FuzzyFinder]ms", "<Cmd>ObsidianSearch<CR>", desc = "obsidian search" },
		{ "[_FuzzyFinder]mq", "<Cmd>ObsidianQuickSwitch<CR>", desc = "obsidian quick switch" },
		{ "[_FuzzyFinder]mt", "<Cmd>ObsidianTags<CR>", desc = "obsidian tags" },
	},
	after = function()
		require("lz.n").trigger_load("fzf-lua")

		vim.opt.conceallevel = 1

		require("obsidian").setup({
			workspaces = {
				{ name = "nago", path = "~/obsidian/valuts/nago" },
			},

			note_id_func = function(title)
				local purified
				if title then
					purified = title:lower():gsub("[^-a-z0-9]+", "-"):gsub("^-+", ""):gsub("-+$", ""):gsub("-+", "-")
					if purified:match("^-*$") then
						purified = nil
					end
				end
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
