local core = require("dataform.core")

local setup = function(opts)
	opts = opts or {}
end

return {
	compile = core.compile,
	setup = setup,
}
