require("neo-tree").setup({
  default_component_configs = {
    git_status = {
      symbols = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "",
        deleted = "",
        ignored = "◌",
      },
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
    },
    follow_current_file = { enabled = true },
  },
})
vim.keymap.set("n", "gx", "<Cmd>Neotree toggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "G,", "<Cmd>Neotree git_status<CR>", { noremap = true, silent = true })
