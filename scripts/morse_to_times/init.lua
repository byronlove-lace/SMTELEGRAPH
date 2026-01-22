local json = require("lib/json")
local file_io = require("utils.file_io")
local transmission = require("utils.transmission")
local c_gen = require("utils.c_gen")

local getScriptDir = function()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)") or "./"
end

local WPM = 1

local args = { ... }
if not args[1] then
	print("Please provide a string as an argument.")
	return
end

local main = function()
	local json_src = getScriptDir() .. "../../data/morse.json"
	local json_data = file_io.read(json_src)
	if json_data == 1 then
		os.exit(1)
	end
	local morse_table = json.decode(json_data)

	local speed = transmission.setSpeed(WPM)
	local trans_times = {
		start = transmission.getTimes(speed, transmission.start(morse_table)),
		body = transmission.getTimes(speed, transmission.body(args[1], morse_table)),
		loop = transmission.getTimes(speed, transmission.loop(morse_table)),
		fin = transmission.getTimes(speed, transmission.fin(morse_table)),
	}

	local h_dest = getScriptDir() .. "../../include/transmission.h"
	local success = file_io.write(h_dest, c_gen.header())
	if success == 1 then
		print("Failed to write header file.")
		os.exit(1)
	end

	local c_dest = getScriptDir() .. "../../src/transmission.c"
	success = file_io.write(c_dest, c_gen.src(trans_times))
	if success == 1 then
		print("Failed to write src file.")
		os.exit(1)
	end
end

main()
