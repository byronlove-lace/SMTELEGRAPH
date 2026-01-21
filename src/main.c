#include "../include/gpio.h"
#include "../include/systick.h"
#include "../include/transmission_timings.h"

bool btn_state;

int main(void) {
  // Initialise LED
  led_init();

  // Initialise Button
  btn_init();

  for (uint32_t i = 0; i < T_START_SIZE; i++) {
    t_start[i].on ? led_on() : led_off();
    systick_msec_delay(t_start[i].duration);
  }

  while (1) {
      for (uint32_t i = 0; i < T_BODY_SIZE; i++) {
        t_body[i].on ? led_on() : led_off();
        systick_msec_delay(t_body[i].duration);
      }

      for (uint32_t i = 0; i < T_LOOP_SIZE; i++) {
        t_loop[i].on ? led_on() : led_off();
        systick_msec_delay(t_loop[i].duration);
      }
    }
      // No END transmission signal yet - need to config RESET
}
