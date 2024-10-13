-- Dataform Compiler Module
--
-- This module is responsible for compiling and managing the compiled files
-- in vim.fn.stdpath('data'), it should be considered a private API.
local config = require("dataform.config")
local utils = require("dataform.utils")

local Compiler = {}

Compiler.compile_project = function()
	if vim.fn.isdirectory(config.DATA_DIR) == 0 then
		vim.system({ "mkdir", "-p", config.DATA_DIR }):wait()
	end
	vim.system({ "dataform", "compile", "--json" }, {
		text = true,
		stdout = function(_, data)
			if data then
				utils.write_file(config.DATA_DIR .. "compilation_result.json", data)
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

---@return table graph
Compiler.parse_json_graph = function()
	local compiled_graph = utils.read_file(config.DATA_DIR .. "compilation_result.json")
	return vim.json.decode(compiled_graph, { object = true, array = true })
end

Compiler.search_graph = function(filename)
	local graph = Compiler.parse_json_graph()
	local result = vim.iter(graph["tables"]):find(function(table)
		local source = utils.get_definitions_path(filename)
		local target = utils.get_definitions_path(table["fileName"])
		return source == target
	end)
	return result
end

Compiler.generate_compiled_action = function(action_config)
	local action_dir = Compiler.get_compiled_action_path(action_config)
	local config_json = vim.json.encode(action_config)
	utils.write_file(action_dir .. "/query.sql", action_config["query"])
	utils.write_file(action_dir .. "/config.json", config_json)
end

Compiler.get_compiled_action_path = function(action_config)
	local parent_dir = action_config["fileName"]:gsub("/[%a_0-9]*%.[jsqlx]+$", "")
	local action_target_name = action_config["target"]["name"]
	local action_dir = config.DATA_DIR .. parent_dir .. "/" .. action_target_name
	if vim.fn.isdirectory(action_dir) == 0 then
		vim.system({ "mkdir", "-p", action_dir }):wait()
	end
	return action_dir
end

return Compiler
