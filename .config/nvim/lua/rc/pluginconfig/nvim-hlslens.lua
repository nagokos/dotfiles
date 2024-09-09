require('hlslens').setup()

local kopts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'x' }, '[_SubLeader]h', function()
	vim.schedule(function()
		if require('hlslens').exportLastSearchToQuickfix() then
			vim.cmd('cw')
		end
	end)
	return ':noh<CR>'
end, { expr = true })

vim.api.nvim_set_keymap('n', 'n',
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts)
vim.api.nvim_set_keymap('n', 'N',
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	kopts)

vim.keymap.set('n', '*', function()
	require("lasterisk").search()
	require('hlslens').start()
end)

vim.keymap.set({ 'n', 'x' }, 'g*', function()
	require("lasterisk").search({ is_whole = false })
	require('hlslens').start()
end)
