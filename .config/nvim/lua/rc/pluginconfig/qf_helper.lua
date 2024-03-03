require("qf_helper").setup()
vim.keymap.set("n", "[_SubLeader]q", "<Cmd>QFToggle!<CR>", { noremap = true, silent = true })
