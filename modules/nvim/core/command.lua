vim.api.nvim_create_user_command("DeleteFile", function()
	local choice = vim.fn.confirm("Really delete this file?", "&Yes\n&No", 2)
	if choice == 1 then
		local current_file = vim.fn.expand("%")
		local success, err = os.remove(current_file)
		if success then
			vim.cmd("bdelete")
			print("File deleted: " .. current_file)
		else
			print("Error deleting file: " .. (err or "Unknown error"))
		end
	else
		print("File deletion cancelled")
	end
end, {})
