local compiler = require("dataform.compiler")

local Dataform = {}

Dataform.setup = function(opts)
	opts = opts or {}
end

Dataform.compile = function()
	compiler.compile_project()
	compiler.generate_files()
end

Dataform.get_compiled_sql = function() end

Dataform.workspace_init()
return Dataform
