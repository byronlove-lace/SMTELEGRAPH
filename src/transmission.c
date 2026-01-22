#include "../include/transmission.h"

const uint32_t T_START_SIZE = 10;
const elem_timing t_start[] = {
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 3600 },
};

const uint32_t T_BODY_SIZE = 18;
const elem_timing t_body[] = {
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 3600 },
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 3600 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 3600 },
};

const uint32_t T_LOOP_SIZE = 10;
const elem_timing t_loop[] = {
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 3600 },
};

const uint32_t T_FIN_SIZE = 12;
const elem_timing t_fin[] = {
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 1200 },
	{ .on = false, .duration = 1200 },
	{ .on = true, .duration = 3600 },
	{ .on = false, .duration = 3600 },
};

