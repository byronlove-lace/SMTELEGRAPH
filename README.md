# STELEGRAPH

## DESCRIPTION

This project aims to program an NUCLEO STM32F411RE MCU to function as a telegraph for morse code.
The NUCLEO STM32F411RE has multiple LEDs that can function as a reciever for morse code and it has two buttons that can serve as an input.

## PROTOTYPING

I've used lua to create a command line tool that will take a user's input, converts it to morse, appends start and end transmission signal (as per the ITU-R M.1677-1 International Morse Code Standard) and then converts said morse into an array of integers that that the STM32 can iterate over in a loop to light the LED. I have also made an additional script that generates a header file with this array, and a src files that use the sysclock on the MCU to count ms.

## PROJECT ROADMAP

- Configure the MCU button to function as an input for morse code
- Configure USART for MCU to PC client communication
- Configure USART to use interrupts for bidirectional commmuncation
- Move morse decoding/encoding logic to the board
- Dynamic encoding (i.e. typing morse fast increases wpm, slow decreases wpm. Same wpm used to decode incoming communication from pc client).
- Add audio and TCP/IP functionality and orchistrate via RTOS

## NOTE ON VENDOR LIBRARY

This project uses the STM32CubeF4 library from ST as a submodule. To keep the repository small, I only track symlinks to the include directories we actually use. After cloning the repository for the first time, run the following script to fetch the library and initialize its submodules:

_scripts/init_submodules.sh_
