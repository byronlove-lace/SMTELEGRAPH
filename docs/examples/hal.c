// uses CMSIS functions for ARM CORE API
#include "stm32f4xx_hal.h"
GPIO_InitTypeDef GPIO_InitStruct = {0};

// Enable the GPIOA Clock
// RCC = Reset and Clock Control
__HAL_RCC_GPIOA_CLK_ENABLE();

// Configure the GPIO pin
GPIO_InitStruct.Pin = GPIO_PIN_5;

// PP =  Push-Pull pin drives high and low
GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
