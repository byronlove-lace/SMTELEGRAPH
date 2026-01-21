local morse = {}

function morse.encode(str_tbl, morse_map)
	local encoded = {}

	for _, char in ipairs(str_tbl) do
		if char == " " then
			table.insert(encoded, " ")
		else
			if morse_map[char] == nil then
				print("Character not found in morse table. \
          Please use R ITU-R International Morse Standard characters only")
				return 1
			end
			table.insert(encoded, morse_map[char])
		end
	end
	return encoded
end

function morse.toUnits(morse_char)
	local units = {
		dit = { on = true, units = 1 },
		dah = { on = true, units = 3 },
		intra_char = { on = false, units = 1 },
		inter_char = { on = false, units = 3 },
		space = { on = false, units = 7 },
	}
	local char_units = {}

	if morse_char == " " then
		return { units["space"] }
	end

	for i = 1, #morse_char do
		local elem = morse_char:sub(i, i)
		if elem == "." then
			table.insert(char_units, units["dit"])
		end
		if elem == "-" then
			table.insert(char_units, units["dah"])
		end

		if i < #morse_char then
			table.insert(char_units, units["intra_char"])
		else
			table.insert(char_units, units["inter_char"])
		end
	end
	return char_units
end

return morse
