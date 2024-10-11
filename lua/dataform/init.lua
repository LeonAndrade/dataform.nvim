local core = require("dataform.core")

local setup = function(opts)
	opts = opts or {}
end

return {
	setup = setup,
	compile = core.compile,
	view_compiled_sql = core.view_compiled_sql,
}
