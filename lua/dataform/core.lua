local dataform_core = {}

dataform_core.compile = function()
	print("Compiling dataform project hey...")

	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_open_win(buf, true, { vertical = true, split = "right" })
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, { "Dataform Compilation Result" })

	vim.system({ "dataform", "compile", "--json" }, {
		text = true,
		stdout = function(err, data)
			if data then
				print("writing to file")
				print(string.len(data))
				print(data)
				-- vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
				local fd = assert(io.open(vim.fn.stdpath("data") .. "/dataform/compilation_result.json", "a"))
				fd:write(data)
				fd:close()
				-- print("Finished writing to file")
			end
			if err then
				print(err)
			end
		end,
	})
	--
	-- vim.fn.jobstart({ "dataform", "compile", "--json" }, {
	-- 	stdout_buffered = true,
	-- 	on_stdout = function(_, data)
	-- 		if data then
	-- 			print("writing to file")
	-- 			vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
	-- 			local fd = assert(io.open(vim.fn.stdpath("data") .. "/dataform/compilation_result.json", "w+"))
	-- 			fd:write(data)
	-- 			fd:close()
	-- 		end
	-- 	end,
	-- })
end

return dataform_core
