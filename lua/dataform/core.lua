local dataform_core = {}

dataform_core.compile = function()
	vim.system({ "dataform", "compile", "--json" }, {
		text = true,
		stdout = function(err, data)
			if data then
				local fd = assert(io.open(vim.fn.stdpath("data") .. "/dataform/compilation_result.json", "a"))
				fd:write(data)
				fd:close()
			end
			if err then
				print(err)
			end
		end,
	})
end

return dataform_core
