local dataform_core = {}

dataform_core.compile = function()
	-- Compile current project
	-- Save file to $XDG_CONFIG_HOME/.local/share/nvim/dataform
	print("Compiling dataform project...")
end

local bufnr = 7
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("MyCoolAugroup", { clear = true }),
	pattern = "main.go",
	callback = function()
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Output of: main.go" })
		vim.fn.jobstart({ "go", "run", "main.go" }, {
			stdout_buffered = true,
			on_stdout = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
				end
			end,
			on_stderr = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
				end
			end,
		})
	end,
})

return dataform_core
