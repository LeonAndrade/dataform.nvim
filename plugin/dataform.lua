if vim.fn.has("nvim-0.7.0") ~= 1 then
	vim.api.nvim_err_writeln("Dataform.nvim requires at least nvim-0.7.0.")
end

vim.api.nvim_create_autocmd("Dataform", function() end)

print("dataform.nvim loaded")
