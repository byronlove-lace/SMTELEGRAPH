local file_io = {}

function file_io.read(file_name)
	local file = io.open(file_name, "r")
	if not file then
		print("Error opening file:", file_name)
		return 1
	end
	local content = file:read("*all")
	file:close()
	return content
end

function file_io.write(file_name, data)
	if not data then
		print("Error: No data provided to write.")
		return 1
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
		return 1
	end

	file:close()
	print("File written successfully:", file_name)
end

return file_io
