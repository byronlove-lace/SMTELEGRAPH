#include "../include/gpio.h"

int main(void) {
  // Initialise LED
  led_init();

  // Superloop
  while (1) {
    led_on();
		for(int i = 0; i < 100000; i++){}
    led_off();
		for(int i = 0; i < 100000; i++){}
  }
}
