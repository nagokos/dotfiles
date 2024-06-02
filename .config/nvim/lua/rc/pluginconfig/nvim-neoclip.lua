require("neoclip").setup({
  history = 10000,
  enable_persistent_history = true,
  db_path = vim.fn.stdpath("state") .. "/databases/neoclip.sqlite3",
  filter = nil,
  preview = true,
  default_register = '"',
  content_spec_column = false,
  on_paste = { set_reg = false },
  on_replay = {
    set_reg = false,
  },
  keys = {
    telescope = {
      i = { select = "<cr>", paste = "<c-x>", paste_behind = "<c-k>" },
      n = { select = "<cr>", paste = "<c-x>", paste_behind = "<c-k>" },
    },
  },
})

require("telescope").load_extension("neoclip")
vim.api.nvim_set_keymap("n", "[_FuzzyFinder]p", "<Cmd>Telescope neoclip<CR>", { noremap = true, silent = true })
