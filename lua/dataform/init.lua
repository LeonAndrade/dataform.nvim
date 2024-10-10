local core = require("dataform.core")

local setup = function(opts)
	opts = opts or {}
	print("dataform.nvim setup ok")
end

return {
	compile = core.compile,
	setup = setup,
}
