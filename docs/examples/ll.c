#include "stm32f4xx_ll_bus.h"
#include "stm32f4xx_ll_gpio.h"

// Enable the GPIOA Clock
// AHB1 = Advanced High Performance Bus 1
// GRP1 = Group 1 (of groups that use AHB1)
// Each bus has a clock thats connected to the CPUs sysclock
// > like arteries in a body
LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOA);

// Configure the GPIO pin
LL_GPIO_SetPinMode(GPIOA, LL_GPIO_PIN_5, LL_GPIO_MODE_OUTPUT);
