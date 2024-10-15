--- Pathfinder Module
---
--- This module is responsible for generating and returning the
--- correct path for a give compiled asset, action path ou base
--- path for storing the compiled results
---
--- The main paths in this project are:
---
--- • workspace_id
---
---   Identifies the absolute path for the current dataform project as
---   the first 16 chars of the sha256 hash of the absolute path.
---
---   The compilation assets are stored in this directory, all the compiled
---   assets should be considered effemeral and are used just to reduce the
---   memory footprint of the operations on the compiled result.
---
---   ex:
---     abs path to project: `$HOME/projects/my-dataform-project`
---     workspace_id: `sha256($HOME/projects/my-dataform-project)[:16]`
---
--- • action_path
---
---   Every action in dataform corresponds to a unique target in the compiled graph
---   all actions must be defined inside the `definitions/` directory inside a
---   .js or .sqlx file.
---
---   Each action file can describe one or more actions. So the base path for a
---   a set of compiled assets for an action file is the action path without the
---   file externsion:
---
---   ex:
---     action_file: `definitions/**/action.sqlx`
---     action_path: `definitions/**/action/`
---
---   This path is used as a common denominator to match compiled assets to the
---   corresponding source file.
---
---
--- Most operations in this plugin involve reading from the current project
--- compiling and saving the result to the workspace data dir, then recompile and
--- present the assets on demand to improve developer experience of dataform projects.
---
local Pathfinder = {}

---@return string workspace_dir Absolute path where compiled assets are saved
function Pathfinder.workspace_dir()
	local workspace_id = vim.fn.sha256(vim.fn.getcwd())
	return vim.fn.stdpath("data") .. "/dataform/" .. string.sub(workspace_id, 0, 16)
end

---@param filename string The fileName key of a dataform action compilation result
---@return ActionPaths action_paths
function Pathfinder.get_action_paths(filename)
	local paths = {}
	paths.relative = filename:match("(definitions/.*)%.[jsqlx]+$")
	paths.compiled = Pathfinder.workspace_dir() .. "/" .. paths.relative
	paths.source = vim.fn.getcwd() .. "/" .. filename
	return paths
end

---@return string current_buf_file Absolute path to the file in the current buffer
function Pathfinder.get_current_file()
	return vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
end

return Pathfinder
