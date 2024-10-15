local pathfinder = require("dataform.pathfinder")
local utils = require("dataform.utils")

local Compiler = {}

local WORKSPACE = pathfinder.get_workspace_dir()

Compiler.compile_project = function()
	if vim.fn.isdirectory(WORKSPACE) == 0 then
		vim.system({ "mkdir", "-p", WORKSPACE }):wait()
	end
	vim.system({ "dataform", "compile", "--json" }, {
		text = true,
		stdout = function(_, data)
			if data then
				utils.write_file(WORKSPACE .. "/compilation_result.json", data)
			end
		end,
	}):wait()
end

Compiler.generate_files = function()
	local graph = Compiler.parse_json_graph()
	vim.iter(graph["tables"]):map(
		---@param table IAction
		function(table)
			Compiler.generate_compiled_action(table)
		end
	)
end

---@return CompilationResult graph
Compiler.parse_json_graph = function()
	local compiled_graph = utils.read_file(WORKSPACE .. "/compilation_result.json")
	return vim.json.decode(compiled_graph, { object = true, array = true })
end

---@param action_config IAction
Compiler.generate_compiled_action = function(action_config)
	local paths = pathfinder.get_action_paths(action_config["fileName"])
	local target_name = action_config["target"]["name"]
	local action_dir = paths.compiled .. "/" .. target_name
	if vim.fn.isdirectory(action_dir) == 0 then
		vim.system({ "mkdir", "-p", action_dir }):wait()
	end
	local config_json = vim.json.encode(action_config)
	utils.write_file(action_dir .. "/query.sql", action_config["query"])
	utils.write_file(action_dir .. "/config.json", config_json)
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

return Compiler
