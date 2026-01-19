local json = require("lib.json")
local file_io = require("utils.file_io")

local getScriptDir = function()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)") or "./"
end

local args = { ... }
if not args[1] then
	print("Please provide a string as an argument.")
	return
end

-- Times
-- -- Active
local on = 1
local dit = 100 -- 1 unit
local dah = 300

-- -- Inactive
local off = 0
local intra_char = 100
local inter_char = 300
local space = 700 -- 7 units

function StringToChars(str)
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

local morseEntryToTimes = function(entry, morse_table)
	local morse_entry_times = {}

	-- Space
	if entry == " " then
		table.insert(morse_entry_times, space)
		return morse_entry_times
	end

	-- Char
	local morse_entry = morse_table[entry]
	if morse_entry == nil then
		print("Character not found in morse table. \
    Please use R ITU-R International Morse Standard characters only")
		return 1
	end

	local morse_entry_table = StringToChars(morse_entry)
	if morse_entry_table == 1 then
		print("Failed to convert morse entry into char array")
		return 1
	end
	assert(type(morse_entry_table) == "table")

	-- Units
	local current = nil
	for _, unit in pairs(morse_entry_table) do
		if current and current ~= unit then
			table.insert(morse_entry_times, intra_char)
		end
		if unit == "-" then
			table.insert(morse_entry_times, on)
			table.insert(morse_entry_times, dah)
			table.insert(morse_entry_times, off)
			current = unit
		end
		if unit == "." then
			table.insert(morse_entry_times, on)
			table.insert(morse_entry_times, dit)
			table.insert(morse_entry_times, off)
			current = unit
		end
	end
	return morse_entry_times
end

local genTransTimings = function(natural_string, morse_table)
	local morse_times = {}

	local natural_table = StringToChars(string.upper(natural_string))
	if natural_string == 1 then
		print("Failed to convert user input into char array.")
		os.exit(1)
	end
	assert(type(natural_table) == "table")

	-- Add start signal
	local start_sig_times = morseEntryToTimes("STR", morse_table)
	if start_sig_times == 1 then
		print("Failed to get start sig times.")
		return 1
	end
	assert(type(start_sig_times) == "table")
	for _, v in ipairs(start_sig_times) do
		table.insert(morse_times, v)
	end

	-- Add Input
	for _, letter in pairs(natural_table) do
		local entry_time = morseEntryToTimes(letter, morse_table)
		if entry_time == 1 then
			print("Failed to get entry times.")
			return 1
		end
		assert(type(entry_time) == "table")
		for _, v in ipairs(entry_time) do
			table.insert(morse_times, v)
		end
	end
	table.insert(morse_times, off)
	table.insert(morse_times, inter_char)

	-- Add end signal times
	local end_sig_times = morseEntryToTimes("END", morse_table)
	if end_sig_times == 1 then
		print("Failed to get end sig times.")
		return 1
	end
	assert(type(end_sig_times) == "table")
	for _, v in ipairs(end_sig_times) do
		table.insert(morse_times, v)
	end

	return morse_times
end

function TableToListString(table)
	if #table == 0 then
		print("Table is empty")
		return 1
	end
	local str = ""
	for _, v in pairs(table) do
		str = str .. v .. "\n"
	end
	str = str:sub(1, -2)
	return str
end

local function main()
	local relative_src = "../../data/raw/morse.json"
	local abs_src = getScriptDir() .. relative_src
	local json_data = file_io.read(abs_src)
	if json_data == 1 then
		os.exit(1)
	end
	local morse_table = json.decode(json_data)

	local morse_times = genTransTimings(args[1], morse_table)
	local times_string = TableToListString(morse_times)

	local relative_dest = "../../data/processed/morse_times.txt"
	local abs_dest = getScriptDir() .. relative_dest
	local success = file_io.write(abs_dest, times_string)
	if success == 1 then
		os.exit(1)
	end
end

main()
