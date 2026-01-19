// MODER = MODE REGISTER
// + 0xXX is the offset
// All Peripherals: BASE + REGISTER OFFSET
// Offsets vary with MCU - listed in Reference Manual (RF)
#define GPIOA_MODER (*(volatile unsigned long *)(GPIOA_BASE + 0x00))
// ENR = Enable Register
// RCC_AHB1ENR = Register of periphs that are enabled on the AHB1
#define RCC_AHB1ENR (*(volatile unsigned long *)(RCC_BASE + 0x30))

//
// (bit << offset)
// i.e 'set the first bit'
// = enable clock for GPIOA on AHB1
RCC_AHB1ENR |= (1 << 0);
// Set PA5 to output mode
// PA5 = bit 10 (bits 10 & 11 determine output mode)
GPIOA_MODER |= (1 << 10); // Set bit 10 (MODER5[1])
