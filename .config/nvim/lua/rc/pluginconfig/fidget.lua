require("fidget").setup({
  notification = {
    window = {
      winblend = 0
    }
  },
  sources = {        -- Sources to configure
    ["null-ls"] = {  -- Name of source
      ignore = true, -- Ignore notifications from this source
    },
  },
})
