local str_mod = {}

function str_mod.strToChar(str)
	if type(str) ~= "string" then
		print("Error: Input is not a valid string.")
		return 1
	end
	local chars = {}
	for i = 1, #str do
		local char = str:sub(i, i) -- sub(from, to)
		table.insert(chars, char)
	end
	return chars
end

return str_mod
