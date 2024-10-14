local config = require("dataform.config")
local compiler = require("dataform.compiler")
local utils = require("dataform.utils")

local Render = {}

Render.compiled_sql = function()
	local action = compiler.search_graph(config.get_current_file())
	local definitions_path = config.get_definitions_path(action["fileName"])
	local sql = utils.read_file(config.get_compiled_action_asset(definitions_path, "/query.sql"))

	local buf = vim.api.nvim_create_buf(false, true)
	for line in sql:gmatch("([^\n]*)\n?") do
		vim.api.nvim_buf_set_lines(buf, -1, -1, false, { line })
	end
	vim.api.nvim_set_option_value("filetype", "sql", { buf = buf })
	vim.api.nvim_open_win(buf, true, { split = "right", width = 120 })
end

return Render
