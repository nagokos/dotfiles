require("neoscroll").setup({
  mappings = { "<C-u>", "<C-d>", "<C-y>", "<C-e>" },
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = nil,       -- Default easing function
  pre_hook = nil,              -- Function to run before the scrolling animation starts
  post_hook = nil,             -- Function to run after the scrolling animation ends
  performance_mode = false,
})

local t = {}

t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "false", "150" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "false", "150" } }
t['<C-y>'] = { 'scroll', { '-0.10', 'true', '70' } }
t['<C-e>'] = { 'scroll', { '0.10', 'true', '70' } }

require("neoscroll.config").set_mappings(t)
