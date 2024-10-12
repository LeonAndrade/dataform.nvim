-- https://github.com/nvim-neorocks/nvim-best-practices

---@class DataformSubcommand
---@field impl fun(args:string[], opts: table) The command implementation
---@field complete? fun(subcmd_arg_lead: string): string[] (optional)

---@type table<string, DataformSubcommand>
local subcdm_tbl = {
	compile = {
		impl = require("dataform").compile,
	},
	view_sql = {
		impl = require("dataform").view_sql,
	},
}

---@param opts table :h lua-guide-commands-create
local function DataformCmd(opts)
	local fargs = opts.fargs
	local subcmd_key = fargs[1]
	local args = #fargs > 1 and vim.list_slice(fargs, 2, #fargs) or {}
	local subcmd = subcdm_tbl[subcmd_key]
	if not subcmd then
		vim.notify("Dataform: Unknown Command: " .. subcmd_key, vim.log.levels.ERROR)
	end
	subcmd.impl(args, opts)
end

vim.api.nvim_create_user_command("Dataform", DataformCmd, {
	nargs = "+",
	desc = "Dataform actions inside nvim",
	complete = function(arg_lead, cmdline, _)
		local subcmd_key, subcdm_arg_lead = cmdline:match("^['<,'>]*Dataform[!]*%s($S+)%s(.*)$")
		if subcmd_key and subcdm_arg_lead and subcdm_tbl[subcmd_key] and subcdm_tbl[subcmd_key].complete then
			return subcdm_tbl[subcmd_key].complete(subcdm_arg_lead)
		end

		if cmdline:match("^['<,'>]*Dataform[!]*%s+%w*$") then
			local subcmd_keys = vim.tbl_keys(subcdm_tbl)
			return vim.iter(subcmd_keys)
				:filter(function(key)
					return key:find(arg_lead) ~= nil
				end)
				:totable()
		end
	end,
	bang = false,
})
