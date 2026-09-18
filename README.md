# STELEGRAPH

A bare-metal Morse code telegraph for the Nucleo-F411RE (STM32F411RE).

Type a message on your PC and the board blinks it out as light — ITU-R M.1677-1-compliant
Morse, transmitted via the on-board LED with millisecond-precise timing derived from the
system clock.

## Overview

STELEGRAPH pairs a Lua toolchain on the host with bare-metal C firmware on the target:

1. **Encode** — a Lua CLI tool converts a text message into Morse per the ITU-R M.1677-1
   International Morse Code standard, appends the standard start- and end-of-transmission
   signals, and represents the result as an array of on/off durations.
2. **Generate** — a companion Lua script emits a C header and source file containing that
   array, ready to compile into the firmware.
3. **Transmit** — the firmware iterates the array and toggles the LED, counting
   milliseconds from the MCU's system clock for accurate element timing.

The project doubles as an exploration of cross-language code generation — a high-level
scripting language producing firmware source that the board consumes at compile time.


## Note on the Vendor Library

This project uses ST's STM32CubeF4 library as a submodule. To keep the repository small,
only symlinks to the include directories actually used are tracked. After cloning for the
first time, run:

```sh
./scripts/init_submodules.sh
```

## Future Work (Parked)

The prototype is complete; ideas parked for a future revisit:

- [ ] Button-based Morse input on the board
- [ ] USART communication between the MCU and a PC client
- [ ] Interrupt-driven bidirectional USART with error handling
- [ ] Move all Morse encode/decode logic on-board
- [ ] Dynamic speed: faster keying raises WPM, slower lowers it (same WPM used to decode
      incoming traffic)
- [ ] Morse-compatibility enforcement on the PC client
- [ ] Audio and TCP/IP support, orchestrated via an RTOS
