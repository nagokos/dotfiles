require("rc/base")

-- ===============================

require("rc/option")
require("rc/display")
require("rc/pluginlist")
require("rc/mappings")
vim.defer_fn(function()
	require("rc/command")
end, 50)
require("rc/autocmd")
