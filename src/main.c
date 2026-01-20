#include "../include/gpio.h"

bool btn_state;

int main(void) {
  // Initialise LED
  led_init();

  // Initialise Button
  btn_init();

  // Superloop
  while (1) {
    // Check if button is pushed
    btn_state = get_btn_state();

    if (btn_state) {
    led_on();
    } else {
      led_off();
    }
  }
}
