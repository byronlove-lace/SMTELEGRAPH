local json = require("lib/json")
local morse = require("utils.morse")
local file_io = require("utils.file_io")
local str_mod = require("utils/str_mod")
local tbl = require("utils/tbl")

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

-- TEST
local encode = morse.encode(input_char, morse_table)
assert(
	tbl.eq(encode, expected_encode),
	string.format(
		"Encode does not match expected output: \nEXPECTED: %s\nENCODE: %s",
		tbl.dump(expected_encode),
		tbl.dump(encode)
	)
)
