#ifndef MORSE_TIMINGS_H
#define MORSE_TIMINGS_H

#include <stdbool.h>
#include <stdint.h>

typedef struct {
	
bool on; // beep
	
uint32_t duration; // duration in ms
	
} elem_timing;

extern const elem_timing t_start[];
extern const elem_timing t_body[];
extern const elem_timing t_loop[];
extern const elem_timing t_fin[];

extern const uint32_t T_START_SIZE;
extern const uint32_t T_BODY_SIZE;
extern const uint32_t T_LOOP_SIZE;
extern const uint32_t T_FIN_SIZE;

#endif // MORSE_TIMINGS_H
