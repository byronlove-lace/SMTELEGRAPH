#include "led_timings.c"
#include <time.h>

int i = 0;

int main(void) {
  while (1) {
    if (i >= LED_TIMINGS_SIZE) {
      i = 19;
    }
  }
}
