local config = require("dataform.config")
local compiler = require("dataform.compiler")
local utils = require("dataform.utils")

local Render = {}

Render.compiled_sql = function()
	local current_file = vim.api.vim_buf_get_name(vim.api.nvim_get_current_buf())
	local definition_path = current_file:match("(definitions/.*)%.[jsqlx]+$")
	local action_config = compiler.search_graph(definition_path)
	vim.print(action_config)

	-- local buf = vim.api.nvim_create_buf(false, true)
	--  local sql = utils.read_file(config.DATA_DIR .. definition_path .. "/query.sql")
	-- for line in sql:gmatch("([^\n]*)\n?") do
	-- 	vim.api.nvim_buf_set_lines(buf, -1, -1, false, { line })
	-- end
	-- vim.api.nvim_set_option_value("filetype", "sql", { buf = buf })
	-- vim.api.nvim_open_win(buf, true, { split = "right", width = 120 })
end

return Render
