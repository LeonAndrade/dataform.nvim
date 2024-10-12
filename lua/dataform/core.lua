local utils = require("dataform.utils")

local dataform_core = {}

local DATA_DIR = vim.fn.stdpath("data")
local COMPILATION_RESULT = DATA_DIR .. "/dataform/compilation_result.json"
local COMPILATION_DIR = DATA_DIR .. "/dataform/compilation_result/"

dataform_core.compile = function()
	vim.system({ "dataform", "compile", "--json" }, {
		text = true,
		stdout = function(_, data)
			if data then
				utils.write_file(COMPILATION_RESULT, data)
			end
		end,
	}):wait()
	dataform_core._build_compilation_dir()
end

dataform_core.view_sql = function()
	print("Should open the compiled version of the current file in a side buffer")
	local current_buf_file = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	local definition_path = current_buf_file:match("(definitions/.*)%.[jsqlx]+$")
	local sql = utils.read_file(COMPILATION_DIR .. definition_path .. "/query.sql")
	local buf = vim.api.nvim_create_buf(false, true)

	-- for line in vim.iter(utils.split_string(sql, "\n")) do
	for line in sql:gmatch("([^\n]*)\n?") do
		vim.api.nvim_buf_set_lines(buf, -1, -1, false, { line })
	end

	vim.api.nvim_set_option_value("filetype", "sql", { buf = buf })

	vim.api.nvim_open_win(buf, true, {
		split = "right",
		width = 100,
	})
end

dataform_core._build_compilation_dir = function()
	local data = utils.read_file(COMPILATION_RESULT)
	local compilation_result = vim.json.decode(data)
	local tables = compilation_result["tables"]

	vim.iter(tables):map(function(table)
		local sql = table["query"]
		local file = table["fileName"]
		local file_parent = string.gsub(file, "/[%a_0-9]*%.[jlqsx]+$", "")
		local file_dir = COMPILATION_DIR .. file_parent .. "/" .. table["target"]["name"]

		if vim.fn.isdirectory(file_dir) == 0 then
			vim.system({ "mkdir", "-p", file_dir }):wait()
		end

		local table_data = vim.json.encode(table)

		utils.write_file(file_dir .. "/query.sql", sql)
		utils.write_file(file_dir .. "/config.json", table_data)
	end)
end

return dataform_core
