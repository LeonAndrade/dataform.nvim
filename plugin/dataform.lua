if vim.fn.has("nvim-0.7.0") ~= 1 then
	vim.api.nvim_err_writeln("Dataform.nvim requires at least nvim-0.7.0.")
end

local dataform_dir = vim.fn.stdpath("data") .. "/dataform"
if vim.fn.isdirectory(dataform_dir) == 0 then
	vim.fn.mkdir(dataform_dir)
end
