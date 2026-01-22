local json = require("lib/json")
local morse = require("utils.morse")
local file_io = require("utils.file_io")
local str_mod = require("utils/str_mod")
local lu = require("lib.luaunit")

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
local expected = { "...", "---", "..." }

-- TEST
local output = morse.encode(input_char, morse_table)
lu.assertEquals(output, expected)
