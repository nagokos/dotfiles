-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-function, unused-local
local function ts_disable(_, bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > 5000
end

require("nvim-treesitter.configs").setup({
  ensure_installed = "all", -- one of 'all', 'language', or a list of languages
  highlight = {
    enable = true,          -- false will disable the whole extension
    disable = {},           -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = { -- mappings for incremental selection (visual mappings)
      node_incremental = "<CR>",
      node_decremental = "<S-CR>",
    },
  },
  indent = { enable = false, disable = { "python", "c", "cpp" } },
  textobjects = { -- syntax-aware textobjects
    select = {
      enable = true,
      disable = {},
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["iB"] = "@block.inner",
        ["aB"] = "@block.outer",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ip"] = "@parameter.inner",
        ["ap"] = "@parameter.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = { ["'>"] = "@parameter.inner" },
      swap_previous = { ["'<"] = "@parameter.inner" },
    },
    move = {
      enable = true,
      goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
      goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
      goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
      goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 300,
    disable = { "cpp" }, -- please disable lua and bash for now
  },
  pairs = {
    enable = true,
    disable = {},
    highlight_pair_events = { "CursorMoved" },                    -- when to highlight the pairs, use {} to deactivate highlighting
    highlight_self = true,
    goto_right_end = false,                                       -- whether to go to the end of the right partner or the beginning
    fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
    keymaps = { goto_partner = "'%" },
  },
  ts_context_commentstring = { enable = true },
  yati = { enable = true, disable = { "markdown", "c", "cpp", "python" }, default_lazy = true }, -- インデントバグっているので
  tree_setter = { enable = true },
})
