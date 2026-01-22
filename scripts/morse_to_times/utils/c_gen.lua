local c_gen = {}

function c_gen.header()
	local h_buff = ""
	h_buff = h_buff .. "#ifndef MORSE_TIMINGS_H\n"
	h_buff = h_buff .. "#define MORSE_TIMINGS_H\n\n"

	h_buff = h_buff .. "#include <stdbool.h>\n"
	h_buff = h_buff .. "#include <stdint.h>\n\n"

	h_buff = h_buff
		.. "typedef struct {\n\t\
bool on; // beep\n\t\
uint32_t duration; // duration in ms\n\t\
} elem_timing;\n\n"

	h_buff = h_buff .. "extern const elem_timing t_start[];\n"
	h_buff = h_buff .. "extern const elem_timing t_body[];\n"
	h_buff = h_buff .. "extern const elem_timing t_loop[];\n"
	h_buff = h_buff .. "extern const elem_timing t_fin[];\n\n"

	h_buff = h_buff .. "extern const uint32_t T_START_SIZE;\n"
	h_buff = h_buff .. "extern const uint32_t T_BODY_SIZE;\n"
	h_buff = h_buff .. "extern const uint32_t T_LOOP_SIZE;\n"
	h_buff = h_buff .. "extern const uint32_t T_FIN_SIZE;\n\n"
	h_buff = h_buff .. "#endif // MORSE_TIMINGS_H\n"

	return h_buff
end

function c_gen.src(t)
	local c_buff = ""
	c_buff = c_buff .. '#include "../include/transmission.h"\n\n'

	c_buff = c_buff .. "const uint32_t T_START_SIZE = " .. #t.start .. ";\n"
	c_buff = c_buff .. "const elem_timing t_start[] = {\n"

	for _, tbl in ipairs(t.start) do
		c_buff = c_buff .. string.format("\t{ .on = %s, .duration = %s },\n", tostring(tbl.on), tostring(tbl.duration))
	end
	c_buff = c_buff .. "};\n\n"

	c_buff = c_buff .. "const uint32_t T_BODY_SIZE = " .. #t.body .. ";\n"
	c_buff = c_buff .. "const elem_timing t_body[] = {\n"

	for _, tbl in ipairs(t.body) do
		c_buff = c_buff .. string.format("\t{ .on = %s, .duration = %s },\n", tostring(tbl.on), tostring(tbl.duration))
	end
	c_buff = c_buff .. "};\n\n"

	c_buff = c_buff .. "const uint32_t T_LOOP_SIZE = " .. #t.loop .. ";\n"
	c_buff = c_buff .. "const elem_timing t_loop[] = {\n"

	for _, tbl in ipairs(t.loop) do
		c_buff = c_buff .. string.format("\t{ .on = %s, .duration = %s },\n", tostring(tbl.on), tostring(tbl.duration))
	end
	c_buff = c_buff .. "};\n\n"

	c_buff = c_buff .. "const uint32_t T_FIN_SIZE = " .. #t.fin .. ";\n"
	c_buff = c_buff .. "const elem_timing t_fin[] = {\n"

	for _, tbl in ipairs(t.fin) do
		c_buff = c_buff .. string.format("\t{ .on = %s, .duration = %s },\n", tostring(tbl.on), tostring(tbl.duration))
	end
	c_buff = c_buff .. "};\n\n"

	return c_buff
end

return c_gen
