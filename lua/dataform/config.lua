local Config = {}

local workspace_id = vim.fn.sha256(vim.fn.getcwd())

Config.DATA_DIR = vim.fn.stdpath("data") .. "/dataform/" .. workspace_id

return Config
