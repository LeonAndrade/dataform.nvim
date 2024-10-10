local dataform_core = {}

dataform_core.compile = function()
	print("Compiling dataform project...")

	-- Compile current project
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_open_win(buf, true, { vertical = true, split = "right" })
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, { "Dataform Compilation Result", "-----", "\n" })

	vim.fn.jobstart({ "dataform", "compile", "--json" }, {
		stdout_buffered = true,

		on_stdout = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
			end
		end,

		on_stderr = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
			end
		end,
	})

	-- Save file to $XDG_CONFIG_HOME/.local/share/nvim/dataform
end

-- local bufnr = 7
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = vim.api.nvim_create_augroup("MyCoolAugroup", { clear = true }),
--   pattern = "main.go",
--   callback = function()
--     vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Output of: main.go" })
--     vim.fn.jobstart({ "go", "run", "main.go" }, {
--       stdout_buffered = true,
--
--       on_stdout = function(_, data)
--         if data then
--           vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
--         end
--       end,
--
--       on_stderr = function(_, data)
--         if data then
--           vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
--         end
--       end,
--     })
--   end,
-- })
--
return dataform_core
