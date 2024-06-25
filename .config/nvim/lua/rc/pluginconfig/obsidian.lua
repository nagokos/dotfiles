vim.opt.conceallevel = 1

require("obsidian").setup({
  workspaces = {
    { name = "nago", path = "~/obsidian/valuts/nago" },
  },

  note_id_func = function(title)
    local purified
    if title then
      purified = title:lower():gsub("[^-a-z0-9]+", "-"):gsub("^-+", ""):gsub("-+$", ""):gsub("-+", "-")
      if purified:match "^-*$" then
        purified = nil
      end
    end
    if not purified then
      purified = ""
      for _ = 1, 4 do
        purified = purified .. string.char(math.random(65, 90))
      end
    end
    return os.date "%Y%m%d-%H%M%S-" .. purified
  end,
  ---@param spec { id: string, dir: obsidian.Path, title: string|? }
  ---@return string|obsidian.Path The full path to the new note.
  note_path_func = function(spec)
    local path
    local filename = spec.title
    if filename then
      filename = vim.fn.substitute(filename, [=[[ \%u3000]]=], "-", "g")
      filename = vim.fn.substitute(filename, [=[['"\\/:]]=], "", "g")
      filename = filename:lower()
      path = spec.dir / (os.date "%Y%m%d-%H%M%S-" .. filename)
    else
      path = spec.dir / spec.id
    end
    return path:with_suffix ".md"
  end,
  ---@return string
  image_name_func = function()
    return tostring(os.date "%Y%m%d-%H%M%S-")
  end,
})

vim.keymap.set("n", "<Leader>on", "<Cmd>ObsidianNew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>os", "<Cmd>ObsidianSearch<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>oq", "<Cmd>ObsidianQuickSwitch<CR>", { noremap = true, silent = true })
