local Utils = {}

---@param path string file path
---@param data string data as text
Utils.write_file = function(path, data)
	local fd = assert(io.open(path, "a+"))
	fd:seek("set", 0)
	if fd then
		fd:write(data)
		fd:close()
	end
end

---@param path string file path
Utils.read_file = function(path)
	local fd = assert(io.open(path, "r"))
	if fd then
		local data = fd:read("*a")
		fd:close()
		return data
	end
end

-- split a string
-- https://gist.github.com/jaredallard/ddb152179831dd23b230
Utils.split_string = function(s, delimiter)
	local result = {}
	local from = 1
	local delim_from, delim_to = string.find(s, delimiter, from)
	while delim_from do
		table.insert(result, string.sub(s, from, delim_from - 1))
		from = delim_to + 1
		delim_from, delim_to = string.find(s, delimiter, from)
	end
	table.insert(result, string.sub(s, from))
	return result
end

Utils.get_definitions_path = function(filepath)
	return filepath:match("(definitions/.*)%.[jsqlx]+$")
end

return Utils
