#include "../include/gpio.h"

// BSRR for atomic gpio bit modification
#define LED_SET GPIO_BSRR_BS5
#define LED_RESET GPIO_BSRR_BR5
#define BTN_PIN GPIO_IDR_ID13

void led_init(void) {
  // Enable clock access to PORT A
  RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

  // Set GPIOA Pin 5 mode to output (01)
  GPIOA->MODER |= GPIO_MODER_MODER5_0;
  GPIOA->MODER &= ~GPIO_MODER_MODER5_1;
}

void led_on(void) {
  // Set PA5 high (BXRR - atomic bit mod to gpio)
  GPIOA->BSRR |= LED_SET;
}

void led_off(void) {
  // Set PA5 low
  GPIOA->BSRR |= LED_RESET;
}

void btn_init(void) {
  // Enable clock access to PORT C
  RCC->AHB1ENR |= RCC_AHB1ENR_GPIOCEN;

  // Set GPIOC Pin 13 to input (00)
  GPIOC->MODER &= ~GPIO_MODER_MODER13_0;
  GPIOC->MODER &= ~GPIO_MODER_MODER13_1;
}

bool get_btn_state(void) {
  // Button is active low (pressed = 0; unpressed = 1)

  // Input Data Register: Check if button is pressed
  if (GPIOC->IDR & BTN_PIN) {
    return false;
  } else {
    return true;
  }

}
