local Config = {}

---@return string workspace_dir Absolute path for the dir where compiled assets are saved
Config.get_workspace_dir = function()
	local workspace_id = vim.fn.sha256(vim.fn.getcwd())
	return vim.fn.stdpath("data") .. "/dataform/" .. string.sub(workspace_id, 0, 16)
end

---@return string definitions_path A path like: definitions/**/*.{js|sqlx}
Config.extract_definitions_path = function(action_filename)
	return action_filename:match("(definitions/.*)%.[jsqlx]+$")
end

---@return string compiled_action_path Absolute path to the compiled action assets directory
Config.get_compiled_action_path = function(definition_path)
	return Config.get_workspace_dir() .. "/" .. definition_path
end

---@param definition_path string Action path relative to the definitions directory
---@param compiled_asset string The desired compiled asset file
---@return string compiled_asset_path Absolute path to the compiled action asset file
Config.get_compiled_action_asset = function(definition_path, compiled_asset)
	return Config.get_compiled_action_path(definition_path) .. compiled_asset
end

---@return string current_buf_file Absolute path to the file in the current buffer
Config.get_current_file = function()
	return vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
end

return Config
