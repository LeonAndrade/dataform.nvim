local Config = {}

local workspace_id = vim.fn.sha256(vim.fn.getcwd())

Config.DATA_DIR = vim.fn.stdpath("data") .. "/dataform/" .. string.sub(workspace_id, 0, 16) .. "/"

return Config
