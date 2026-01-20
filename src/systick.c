#include "systick.h"

#define CTRL_ENABLE (1U<<0)
#define CTRL_CLKSRC (1U<<2) // processor clock
#define CTRL_COUNTFLAG (1U<<16) // 1 if timer reaches 0

// sysclock uses internal RC ocilator: 16MHz
#define ONE_MSEC_LOAD 1600

void systick_msec_delay(uint32_t delay)
{
  // ARM Generic User Guide (AGUG): SYST_RVR (RELOAD)
  SysTick->LOAD = ONE_MSEC_LOAD - 1; // counts from 0

  // AGUG: SYST_CVR (CURRENT)
  SysTick->VAL = 0; // also sets COUNTFLAG to 0

  // AGUG: SYST_CSR (CLKSOURCE)
  SysTick->CTRL = CTRL_CLKSRC; // select internal clocksource and reset the register

  // AGUG: SYST_CSR (ENABLE)
  SysTick->CTRL |= CTRL_ENABLE; // Enable SysTick

  for (uint32_t i = 0; i < delay; i++) {
    while((SysTick->CTRL & CTRL_COUNTFLAG) == 0) {} // loop until timer reaches 0
  }

  SysTick->CTRL = 0;
}
