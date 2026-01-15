function GetScriptDir()
	local path = debug.getinfo(1, "S").source:match("@(.*[\\/])") -- Extract the directory from the script path
	return path
end

local json = require(GetScriptDir() .. "json")
local args = { ... }

if not args[1] then
	print("Please provide a string as an argument.")
	return
end

local on = 1
local dit = 100
local dah = 300

local off = 0
local intra_char = 100
local inter_char = 300
local space = 700

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

function ReadFile(file_name)
	local file = io.open(file_name, "r")
	if not file then
		print("Error opening file:", file_name)
		return 1
	end
	local content = file:read("*all")
	file:close()
	return content
end

function WriteFile(file_name, data)
	if not data then
		print("Error: No data provided to write.")
		return 3
	end

	local file, err = io.open(file_name, "w")
	if not file then
		print("Error opening or creating file:", err)
		return 1
	end

	local success, write_err = pcall(function()
		file:write(data)
	end)

	if not success then
		print("Error writing to file:", write_err)
		file:close()
		return 2
	end

	file:close()
	print("File written successfully:", file_name)
end

function BinToMorseTimes(binary_input, morse_table)
	local morse_times = {}
	for _, letter in pairs(binary_input) do
		if letter == " " then
			table.insert(morse_times, space)
		else
			local morse_entry = morse_table[letter]
			Current = nil
			for _, morse_char in pairs(morse_entry) do
				if Current and morse_char ~= Current then
					table.insert(morse_times, off)
					table.insert(morse_times, intra_char)
				end
				if morse_char == 1 then
					table.insert(morse_times, on)
					table.insert(morse_times, dah)
					table.insert(morse_times, off)
				end
				if morse_char == 0 then
					table.insert(morse_times, on)
					table.insert(morse_times, dit)
					table.insert(morse_times, off)
				end
				Current = morse_char
			end
			table.insert(morse_times, off)
			table.insert(morse_times, inter_char)
		end
	end
	return morse_times
end

function TableToCsv(table)
	local str = ""
	for _, v in pairs(table) do
		str = str .. v .. ","
	end
	str = str:sub(1, -2)
	return str
end

local function main()
	local relative_src = "../../data/raw/morse.json"
	local abs_src = GetScriptDir() .. relative_src
	local json_data = ReadFile(abs_src)
	if json_data == 1 then
		os.exit(1)
	end
	local morse_table = json.decode(json_data)

	local untranslated = StringToChars(string.upper(args[1]))
	if untranslated == 1 then
		os.exit(1)
	end
	assert(type(untranslated) == "table")

	local morse_times = BinToMorseTimes(untranslated, morse_table)
	local times_csv = TableToCsv(morse_times)

	local relative_dest = "../../data/processed/morse.csv"
	local abs_dest = GetScriptDir() .. relative_dest
	local success = WriteFile(abs_dest, times_csv)
	if success == 1 or success == 2 then
		os.exit(1)
	end
end

main()
