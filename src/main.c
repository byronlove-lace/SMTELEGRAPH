#include "../include/main.h"

int main(void) {
  // Enable clock access to GPIOA
  RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

  // Set GPIOA Pin 5 mode to output (01)
  GPIOA->MODER |= GPIO_MODER_MODER5_0;
  GPIOA->MODER |= ~GPIO_MODER_MODER5_1;

  // Superloop
  while (1) {
    // Set PA5 (LED Pin) to high
    GPIOA->ODR |= GPIO_ODR_ODR_5;
  }
}
