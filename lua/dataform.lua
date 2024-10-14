local compiler = require("dataform.compiler")
local render = require("dataform.render")

local Dataform = {}

Dataform.setup = function(opts)
	opts = opts or {}
end

Dataform.compile = function()
	compiler.compile_project()
	compiler.generate_files()
end

Dataform.render_sql = function()
	render.compiled_sql()
end

return Dataform
