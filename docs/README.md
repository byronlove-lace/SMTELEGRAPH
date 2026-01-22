# SMTYPOGRAPH

## DESCRIPTION

This project aims to program an NUCLEO SMT32F411RE MCU to function as a typograph for morse code.
The NUCLEO SMT32F411RE has multiple LEDs that can function as a reciever for morse code and it has two buttons that can serve as an input.

I've used lua to create a command line tool that will take a user's input, converts it to morse, appends start and end transmission signal (as per the ITU-R M.1677-1 International Morse Code Standard) and then converts said morse into an array of integers that that the STM32 can iterate over in a loop. I have also made an additional script that generates a header file with this array.

At the moment, I have a LED toggle that uses the CMSIS as proof of concept, hover I plan on using the HAL for more robust code (and because it makes managing time much easier).

## PROJECT ROADMAP

- Add testing for led output.
- Configure the MCU to function as an input for morse code with a client for translating the code on host.
- Add a porentiometer to the board to set WPM with one of the LEDs serving as a measure (unused button causes unused led to blink: 10WPM per blink).

## NOTE ON VENDOR LIBRARY

This project uses the STM32CubeF4 library from ST as a submodule.
To keep the repository small, I only track symlinks to the headers we actually use.
After cloning the repository for the first time, run the following script to fetch the library and initialize its submodules:

_scripts/init_submodules.sh_

```

```
