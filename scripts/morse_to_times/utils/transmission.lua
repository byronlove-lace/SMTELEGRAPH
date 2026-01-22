local morse = require("morse")
local str_mod = require("str_mod")

local transmission = {}

function transmission.start(morse_table)
	return morse.toUnits(morse_table["STR"])
end

function transmission.loop(morse_table)
	return morse.toUnits(morse_table["+"])
end

function transmission.fin(morse_table)
	return morse.toUnits(morse_table["END"])
end

function transmission.body(msg, morse_tbl)
	local caps_msg = string.upper(msg)
	local msg_tbl = str_mod.strToChar(caps_msg)
	local morse_msg = morse.encode(msg_tbl, morse_tbl)
	local msg_units = {}
	for _, morse_char in ipairs(morse_msg) do
		-- flatten table
		local char_units = morse.toUnits(morse_char)
		for _, u in ipairs(char_units) do
			table.insert(msg_units, u)
		end
	end
	return msg_units
end

function transmission.setSpeed(wpm)
	local word = 50 -- standard 'word' in morse is 'PARIS ' (50 units)

	local units_per_min = word * wpm
	local units_per_sec = units_per_min / 60
	local ms_per_unit = 1000 / units_per_sec

	return ms_per_unit
end

function transmission.getTimes(ms_per_unit, msg_units)
	local round = function(num)
		if num >= 0 then
			return math.floor(num + 0.5)
		else
			return math.ceil(num - 0.5)
		end
	end

	local scaled = {}
	for i, tbl in ipairs(msg_units) do
		scaled[i] = { on = tbl.on, duration = round(tbl.units * ms_per_unit) }
	end
	return scaled
end

return transmission
