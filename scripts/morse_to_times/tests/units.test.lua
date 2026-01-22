local json = require("lib.json")
local lu = require("lib.luaunit")
local transmission = require("utils.transmission")
local file_io = require("utils.file_io")

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

local units = {
	dit = { on = true, units = 1 },
	dah = { on = true, units = 3 },
	intra_char = { on = false, units = 1 },
	inter_char = { on = false, units = 3 },
	space = { on = false, units = 7 },
}

local expected = {
	units.dit,
	units.intra_char,
	units.dit,
	units.intra_char,
	units.dit,
	units.inter_char,
	units.dah,
	units.intra_char,
	units.dah,
	units.intra_char,
	units.dah,
	units.inter_char,
	units.dit,
	units.intra_char,
	units.dit,
	units.intra_char,
	units.dit,
	units.inter_char,
}

-- TEST
local output = transmission.body(input, morse_table)
lu.assertEquals(output, expected)
