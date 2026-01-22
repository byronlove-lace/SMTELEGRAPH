local morse = require("utils.morse")
local file_io = require("utils.file_io")
local json = require("lib/json")
local str_mod = require("utils/str_mod")

-- DATA
local getScriptDir = function()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)") or "./"
end

local json_src = getScriptDir() .. "../../../data/morse.json"
local json_data = file_io.read(json_src)
if json_data == 1 then
	os.exit(1)
end
local morse_table = json.decode(json_data)

-- INPUT - EXPECTATION
local input = "SOS"
local input_char = str_mod.strToChar(input)
local expected_encode = { "...", "---", "..." }

-- HELPERS
local dump = function(t)
	local out = {}
	for _, v in ipairs(t) do
		out[#out + 1] = tostring(v)
	end
	return "{ " .. table.concat(out, ", ") .. " }"
end

local table_eq = function(a, b)
	if #a ~= #b then
		return false
	end
	for i = 1, #a do
		if a[i] ~= b[i] then
			return false
		end
	end
	return true
end

local encode = morse.encode(input_char, morse_table)
assert(
	table_eq(encode, expected_encode),
	string.format(
		"Encode does not match expected output: \nEXPECTED: %s\nENCODE: %s",
		dump(expected_encode),
		dump(encode)
	)
)
