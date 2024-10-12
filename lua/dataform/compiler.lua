-- Dataform Compiler Module
--
-- This module is responsible for compiling and managing the compiled files
-- in vim.fn.stdpath('data'), it should be considered a private API.
local config = require("dataform.config")
local utils = require("dataform.utils")

local Compiler = {}

Compiler.compile_project = function()
	vim.system({ "dataform", "compile", "--json" }, {
		text = true,
		stdout = function(_, data)
			if data then
				utils.write_file(config.DATA_DIR .. "", data)
			end
		end,
	}):wait()
end

Compiler.generate_files = function()
	local graph = Compiler.parse_json_graph()
	vim.iter(graph["tables"]):map(function(table)
		Compiler.generate_compiled_action(table)
	end)
end

Compiler.parse_json_graph = function()
	local compiled_graph = utils.read_file(config.COMPILATION_RESULT_JSON)
	return vim.json.decode(compiled_graph, { object = true, array = true })
end

Compiler.generate_compiled_action = function(action_config)
	local parent_dir = action_config["fileName"]:gsub("/[%a_0-9]*%.[jsqlx]+$", "")
	local action_target_name = action_config["target"]["name"]
	local action_dir = parent_dir .. "/" .. action_target_name

	if vim.fn.isdirectory(action_dir) == 0 then
		vim.system({ "mkdir", "-p", action_dir }):wait()
	end

	local config_json = vim.json.encode(action_config)
	utils.write_file(action_dir .. "/query.sql", action_config["query"])
	utils.write_file(action_dir .. "/config.json", config_json)
end

return Compiler
