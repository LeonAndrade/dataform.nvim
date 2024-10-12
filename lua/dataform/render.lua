local config = require("dataform.config")
local utils = require("dataform.utils")

local Render = {}

Render.compiled_sql = function()
	local current_file = vim.api.vim_buf_get_name(vim.api.nvim_get_current_buf())
	local definition_path = current_file:match("(definitions/.*)%.[jsqlx]+$")
	utils.read_file()
end

return Render
