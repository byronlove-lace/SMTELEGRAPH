#include "../include/uart.h"

// reference manual table 75;
#define SYS_FREQ 16000000U
#define APB1_CLK SYS_FREQ
#define BAUD_RATE 460800U

static uint16_t calc_usartdiv(uint32_t over8, uint32_t periph_clk, uint32_t baud_rate) {
  // datasheet:3.22
  const uint32_t mx_baud = 6250000U;
  const uint32_t mx_clk = 16000000U;

  assert((over8 & ~1U) == 0);
  assert(periph_clk <= mx_clk);
  assert(baud_rate <= mx_baud);

  // reference manual:19.3.4
  // 16 bit register & round
  uint32_t divisor = 8U * (2U - over8) * baud_rate;
  return (uint16_t)((periph_clk + (divisor / 2U)) / divisor);
 }

void uart_init(void) {
  // Enable Clock access to GPIOA
  RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

  // Set PA2 to AF mode (1, 0)
  GPIOA->MODER &= ~GPIO_MODER_MODER2_0;
  GPIOA->MODER |= GPIO_MODER_MODER2_1;

  // Set PA2 AF to AF7 (USART_TX)
  GPIOA->AFR |= GPIO_AFRL_AFSEL2_0
  GPIOA->AFR |= GPIO_AFRL_AFSEL2_1
  GPIOA->AFR |= GPIO_AFRL_AFSEL2_2
  GPIOA->AFR &=~ GPIO_AFRL_AFSEL2_3

  // Enable Clock access for USART2
  RCC->APB1ENR |= RCC_APB1ENR_USART2EN

  uint32_t oversample_16 = 0
  USART2->BRR = calc_usartdiv(oversample_16, APB1_CLK, BAUD_RATE)
  USART2->CR1 |= USART_CR1_TE
  USART2->CR1 |= USART_CR1_UE
}
