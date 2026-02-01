# UART
*Universal Asynchronous Receiver/Transmitter*

## History

**RS-232**
- 1962 created by the **EIA**.
- Defines **electrical signaling**, voltages (±12 V), connectors, and pinouts.
- Uses **asynchronous serial framing** (start, data, stop).

**UART**
- 1970s
- **MSI ICs** make serial practical.
- Handles framing, baud rate, sampling.
- RS-232 becomes cheap and widespread.

**UART + RS-232**
* UARTs integrated into PCs (8250, 16450, 16550).
* DB-9 connectors become common.
* RS-232 is the default PC serial interface.

**RS-422 / RS-485**
- 1980s/90s
- Improve RS-232 electrically.
- Use **differential signaling**.
- Longer distance, higher speed, multi-drop (RS-485).
- Still use UART framing.

**UART + MCUs**
- 1990s
- UARTs move into **microcontrollers**.
- Voltage drops to **TTL (3.3 V / 5 V)**.
- Same UART logic, no RS-232 voltages anymore.
- Level shifters (MAX232) bridge UART ↔ RS-232.

**USBs**
- PCs lose COM ports.
- USB becomes dominant.
- USB-to-serial adapters emulate UART.
- UART survives as a logical interface.

**Today**
- UART stays for **debug, bootloaders, embedded comms**.
- RS-232 mostly disappears physically.
- High-speed serial (USB, PCIe, Ethernet) takes over.

## Background
**NRZ (Non-Return-to-Zero)**

- Each bit sent as a const voltage level for bit time:
- Signal does **not return to zero between bits** 
- It only changes when the bit value changes.

- `1` → HIGH
- `0` → LOW

So `11` is just **HIGH held for two bit times**.

**Bit Time**
- Time duration in NZR
- Tbit = 1/baud

## General Details
**Communication Protocol**

**Asynchronous**
- 1 bit at a time w/o clock signal
- Not Paralell:
  - Multiple bits over multiple channels simulataneosly 
  - Uncommon in embedded
- Uses start/stop bits to sync data transmission

**Point-to-Point**
- Direct line of communication

**Full-Duplex**
- Simultaneous 2-way communication
- 2 lane road

**Both devices must agree on baud rate and format**

## Assesment
**The Good**
- Simple and Cost Effective
- Wide Support

**The Bad**
- Short distanc
- P2P only

**The Ugly**
- Usually slower than I2C and SPI *because of its async*:
  - Overhead of start/stop bits
  - Conservative timing margins cuz of async

## Usecase
- Serial communication with PCs
- GPS
- Bluetooth

## Interface
- UART_DEV1 (TX) ------ (RX) UART_DEV2
- UART_DEV1 (RX) ------ (TX) UART_DEV2
- UART_DEV1 (GND) ------ (GND) UART_DEV2

| Pin | Name | Details |
| --- | --- | --- |
| RX | Recieved Data Input |
| TX | Transmit Data Output | High (idle) by default (when enabled)

## UART Data Frame
{*Reference Manual 19.3*}
| Start Bit | Data Bits | Parity Bit | Stop Bit(s) |
| --- | --- | --- | ---|
| 1 Tbit | 8-9 Tbit word len | 1 Tbit | 1 to 2 Tbits
| High -> Low (0) | Big-Endian | Odd or Even  | Low -> High(1) |
| 1 Tbit time | config w/ M bit | | |
| | 1 Byte / 'character' | | |


All sectors of the dataframe need to be agreed on at the outset of communication

## Start Bit
Start bit detection sequence: 1 1 1 0 X 0 X 0 X 0 0 0 0.

## USART
- *Universal Synchronous/Asynchronous Receiver/Transmitter*
- **Synchronous mode (USART):** Both sides share a clock line
- Advantages: precise timing, higher speeds possible.
- Drawbacks: extra wiring, sensitive to skew/noise, both sides must exactly match clock.

## Oversampling
- Used by reciever in async
- Distinguish data and noise
- OVER8 bit in USART_CR1 reg
  - OVER8=1: 8 times the baud rate
  - OVER8=0: 16 times the baud rate

**Oversampling 8**
- Higher speed (up to fPCLK/8)
- Reduce max clock deviation tolerance

**Oversampling 16**
- Lower speed (up to fPCLK/16)
- Increase max clock deviation tolerance

## Baud Rate
**Overview**
- Signal changes per second
  - Simple/small systems: bits per second (== bit rate)
  - Larger systems: signals can have 1+ bits
- Must be agreed on by both sides

**General Speeds**
| Speed | Description |
| --- | --- |
| 300 bps | Slow, used for long-distance comms w/ limited bandwidth |
| 9,600 bps | Default for many devices/MCUs |
| 19,200 bps | Faster, more data-intensive applications |
| 115,200 bps | High-speed, applications requiring quick data transfer |

**Calculating Baud Rate**

- Tx/Rx baud = fCK / (8 * (2 - OVER8) * USARTDIV)
  - Tx/Rx baud = fCK / 8 * USARTDIV <oversampling 8>
  - Tx/Rx baud = fCK / 16 * USARTDIV <oversampling 16>
- USARTDIV = fCK / (8 * (2 - OVER8) * desiredBaud)

*The lower the CPU clock the lower the accuracy for a particular baud rate. The upper limit of the achievable baud rate can be fixed with these data.*

**Setting Baud**
- Set fCK and OVER8
- Use desired baud to calc USARTDIV
- Set USARTDIV in USART_BRR

## Deviation Tolerance
**Overview**

*USART async receiver works correctly only if the total clock system deviation is
smaller than the USART receiver’s tolerance.*

Deviation tolerance relates to timing. **It is not related to signal/noise**.
Often makes tradeoffs in that regard.

**Sources of Deviation**
| Acronym | Description |
| --- | ---|
| DTRA | Transmitter error (e.g. deviation of the transmitter’s local oscillator) |
| DQUANT | Error in baud rate quantization of the receiver |
| DREC | Receiver’s local oscillator |
| DTCL | Transmission line (e.g transceivers introduce an asymmetry between the low-to-high transition timing and the high-to low transition timing) |

**Desired Tolerance**

DTRA + DQUANT + DREC + DTCL < USART receiver’s tolerance


**Recievers Tolerance when DIV fraction is 0**
| M Bit | OVER8=0, ONEBIT=0 | OVER8=0, ONEBIT=1 | OVER8=1, ONEBIT=0 | OVER8=1, ONEBIT=1 |
|------:|------------------|------------------|------------------|------------------|
|   0   | 3.75%            | 4.375%           | 2.50%            | 3.75%            |
|   1   | 3.41%            | 3.97%            | 2.27%            | 3.41%            |


**Recievers Tolerance when DIV fraction is NOT 0**
| M Bit | OVER8=0, ONEBIT=0 | OVER8=0, ONEBIT=1 | OVER8=1, ONEBIT=0 | OVER8=1, ONEBIT=1 |
|------:|------------------|------------------|------------------|------------------|
|   0   | 3.33%            | 3.88%            | 2.00%            | 3.00%            |
|   1   | 3.03%            | 3.53%            | 1.82%            | 2.73%            |

**Factors that Affect Tolerance**
- ONEBIT: helps bc receiver samples 1 bit instead of needing range of 3.
- DIV_Fraction 0: helps bc integer division avoids clock jitter; keep sample points evenly spaced.
- Mbit: more bits to drift 
  - Only change to 1 for protocol needs

**Example**
{reference manual 19.3.4; table 75}
MBit = 0; OVER8=1 (16bit oversampling for noise); ONEBIT=0 (3 bit validation for noise); DIV fraction != 0 (just cuz)
*Our deviation tolerance is 2.00%. We choose the highest baud rate in that range*
If we compare against the STM32F411 Reference Manuals baud rate err calcuation table. Our desired baud rate is:
460.8 KBps (max speed in acceptable bounds)


## UART Driver

**Default USART Access**
{board usermanual 7.10}

- Default Pins: ST-LINK  - PA2 & PA3 - USART2 (default)
- STM32: USART2 <VCOM> ST-LINK MCU enabled
- Virtual COM port (SB13 and SB14 ON, SB62 and SB63 OFF)

- *Default config can be changed w/ solder bridges and flying wires*
- VCOM: Virtual Com (RS-232) ports (USB - UART)

**Bus and Rates**
{*datasheet 3.22*}

| UART | MxBaud (oversample 16) | MxBaud (oversample 8) | APB Mapping |
| --- | --- | --- | ---|
| USART1 | 12.5 Mbit/s | 6.25 Mbit/s | APB2 (max 100MHz)
| USART2 | 6.25 Mbit/s | 3.12 Mbit/s | APB1 (max 50MHz)
| USART6 | 12.5 Mbit/s | 6.25 Mbit/s | APB2 (max 100MHz)


**GPIO Pins**
{board usermanual table 8 & 9}

| Pin | USART Line | Alternate Function |     AF Details     |
| --- | ---------  | ------------------ | ------------------ |
| PA2 | USART2_TX  | AF7                | 0111 on GPIOx_AFRL |
| PA3 | USART2_RX  | AF7                | 0111 on GPIOx_AFRL |

- *GND  connection not necessary as ST-LINK and STM32 already share ground*

**Summary**
**Q:** How do we enable serialized communication with the STM32?
**A:** Enable PA2 and PA3 on the APB1 Bus with AF7 config for ST-LINK accesss to USART2_TX and USART2_RX
