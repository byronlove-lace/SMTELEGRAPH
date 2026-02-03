# CLOCKS
{RM0383 6.2}
{DS10314 Rev 8}
{7.9 UM1724}

## Oscillators (OSC)

- Physical system that produces a consistent periodic signal

## Quartz & Ceramics

- Piezoelectric
  - VoltageA > Crystal Lattice Structure (Vibrates) > VoltageB
  - Highly predictable and durable OSC

## Clock Sources

**Clock Sources (OSC) for SYSCLK**
| Acronym | Name | Description |
| --- | --- | --- |
| HSI | High Speed Internal | RC. 16MHz. Default on reset. Use directly as SYSCLK or PLL input. 1% accurate at 25C |
| HSE | High Speed External | Crystal/Ceramic resonator. Highly accurate. Not available at startup. 4-26MHz. |
| Main PLL | Phase Locked Loop | Multiplies/Divides frequency. |

**Table Notes**
- **RC**: Resistor-Capacitor
- There is no pre-supplied fast HSE on the NUCLEO STM32F411xe board. Can be soldered or plugged as an external unit.

**PLL**:
- 2 (possible) inputs: HSE or HSI
- 2 ouputs: 1) SYSCLK (<=100MHz) 2) USB OTG FS (=48MHz) / SDIO(<=50MHz)|

**Other Clock Sources**
| Acronym | Name | Description |
| --- | --- | --- |
| LSE | Low Speed External | Low speed (32.768 kHz) but highly accurate. Comes w/ NUCLEO board |
| LSI | Low Speed Internal | Low speed (32.768 kHz) but highly accurate. Low power mode clock sourc |

## Prescalers
Used to configure:

| Domain | Speed | Mx Frequency | Clock |
| --- | --- | --- | --- |
| AHB | Fast | 100MHz | HCLK |
| APB2 | Fast | 100MHz | PCLK1 |
| APB1 | Slow | 50MHz | PCLK2 |

**Prescaler Workflow**
- HSI or HSE → PLL → SYSCLK → AHB/APB prescalers → HCLK → CPU & peripherals
- Configured in RCC register

## Other Clocks

**HCLK**
Bus: AHB (Advanced High-performance Bus)
Domain: Core / backbone
Feeds:
- Cortex-M CPU
- SysTick
- SRAM
- Flash interface
- DMA
- GPIO
- AHB peripherals

**PCLK1**
Bus name: APB1 (Advanced Peripheral Bus 1)
Domain: Low-speed peripherals
Feeds:
- TIM2–TIM7
- USART2 / USART3
- I2C1 / I2C2
- SPI2
- CAN
- DAC
- PWR

**PCLK2**
Bus name: APB2 (Advanced Peripheral Bus 2)
Domain: High-speed peripherals
Feeds:
- TIM1
- USART1
- SPI1
- ADC
- GPIO (some families)
- AFIO / SYSCFGs

## Timers and Other
| Acronym | Name | Description |
| --- | --- | --- |
| RTC | Real Time Clock | BCD. Datetime clock. Accounts for leap year. Clocked by LSE or LSI. |

## SysTick

- A 24-bit downcounter
- Auto reload capability
- Maskable system interrupt generation when the counter reaches 0
- Programmable clock source.
- Source: HCLK
  - HCLK / 8 ('external' - aka via RCC prescale - SYSTCSR = 0) < stops overflow at high HCLK
  - HCLK ('internal' SYSTCLK = 1)
