local getScriptDir = function()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)") or "./"
end

local file_io = require(getScriptDir() .. "utils.file_io")

local txtFileToArr = function(file_path)
	local lines = {}
	local txt_string = file_io.read(file_path)
	if txt_string == 1 then
		print("Failed to read text string for array parsing.")
		return 1
	end
	for line in txt_string:gmatch("([^\n\r]+)") do
		table.insert(lines, line)
	end
	return lines
end

local genArrHeaders = function(arr)
	local h_buff = ""
	h_buff = h_buff .. "#ifndef LED_TIMINGS_H\n"
	h_buff = h_buff .. "#define LED_TIMINGS_H\n\n"
	h_buff = h_buff .. "extern const int LED_TIMINGS_SIZE;\n"
	h_buff = h_buff .. "extern const int led_timings[];\n"
	h_buff = h_buff .. "#endif // LED_TIMINGS_H\n"

	local c_buff = ""
	c_buff = c_buff .. '#include "../include/led_timings.h"\n\n'
	c_buff = c_buff .. "const int LED_TIMINGS_SIZE = " .. #arr .. ";\n"
	c_buff = c_buff .. "const int led_timings[LED_TIMINGS_SIZE] = {\n"
	for _, num in ipairs(arr) do
		c_buff = c_buff .. string.format("%d, \n", num)
	end
	c_buff = c_buff .. "};\n\n"

	return h_buff, c_buff
end

local main = function()
	local rel_txt_src = "../../data/processed/morse_times.txt"
	local abs_txt_src = getScriptDir() .. rel_txt_src

	local rel_h_dest = "../../include/led_timings.h"
	local abs_h_dest = getScriptDir() .. rel_h_dest
	local rel_c_dest = "../../src/led_timings.c"
	local abs_c_dest = getScriptDir() .. rel_c_dest

	local morse_times_arr = txtFileToArr(abs_txt_src)
	if morse_times_arr == 1 then
		print("Failed to read morse times from " .. rel_txt_src)
		os.exit(1)
	end
	local h_str, c_str = genArrHeaders(morse_times_arr)

	local success = file_io.write(abs_h_dest, h_str)
	if success == 1 then
		print("Failed to write h file to path.")
		os.exit(1)
	end

	success = file_io.write(abs_c_dest, c_str)
	if success == 1 then
		print("Failed to write c file to path.")
		os.exit(1)
	end
end

main()
