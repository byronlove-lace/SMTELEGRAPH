#include "../include/gpio.h"

#define GPIOAEN (1U<<0)
#define LED_BS5 (1U<<5) // Bit set Pin 5
#define LED_BR5 (1U<<21) // Bit reset Pin 5

void led_init(void) {
  // Enable clock access to GPIOA
  RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

  // Set GPIOA Pin 5 mode to output (01)
  GPIOA->MODER |= GPIO_MODER_MODER5_0;
  GPIOA->MODER &= ~GPIO_MODER_MODER5_1;
}

void led_on(void) {
  // Set PA5 high
  GPIOA->BSRR |= LED_BS5;
}

void led_off(void) {
  // Set PA5 low
  GPIOA->BSRR |= LED_BR5;
}
