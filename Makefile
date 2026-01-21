# CONFIGS
## Logger Settings
TIMESTAMP := $(shell date +"%Y%m%d_%H%M%S")
OPENOCD_LOG = logs/$(TIMESTAMP)_openocd.log
GDB_LOG = logs/$(TIMESTAMP)_gdb.log

## Compiler Settings
CC = arm-none-eabi-gcc
CFLAGS = -c -mcpu=cortex-m4 -mthumb -std=gnu11 -Wall -Wextra
CINCLUDES = -Iinclude -Iinclude/cmsis -Iinclude/stm32f4xx
CFLAGS += $(CINCLUDES)

## Linker Settings
MAIN_MAP = build/debug/main.map
LD_SCRIPT = build/ld/stm32_ls.ld
LDFLAGS = -nostdlib -T$(LD_SCRIPT) -Wl,-Map=$(MAIN_MAP)

## Src + Obj Paths
MAIN_SRC = src/main.c
MAIN_OBJ = build/obj/main.o
STARTUP_SRC = build/src/stm32f411_startup.c
STARTUP_OBJ = build/obj/stm32f411_startup.o
GPIO_SRC = src/gpio.c
GPIO_OBJ = build/obj/gpio.o
SYSTICK_SRC = src/systick.c
SYSTICK_OBJ = build/obj/systick.o
TRANSMISSION_SRC = src/transmission_timings.c
TRANSMISSION_OBJ = build/obj/transmission.o

## Bin + Elf Paths
TARGET_ELF = bin/main.elf
TARGET_BIN = bin/main.bin

## OpenOCD Paths
DEBUGGER=interface/stlink.cfg
BOARD=board/st_nucleo_f4.cfg

# COMMANDS
build: $(TARGET_ELF)

load:
	openocd -d -f $(DEBUGGER) -f $(BOARD) 2>&1 | tee $(OPENOCD_LOG)

debug:
	gdb -ex "target extended-remote :3333" $(TARGET_ELF) 2>&1 | tee $(GDB_LOG)

clean:
	rm -f $(STARTUP_OBJ) $(MAIN_OBJ) $(MAIN_MAP) $(TARGET_ELF)

# BUILD
## Compile
$(MAIN_OBJ) : $(MAIN_SRC)
	$(CC) $(CFLAGS) $< -o $@

$(STARTUP_OBJ) : $(STARTUP_SRC)
	$(CC) $(CFLAGS) $< -o $@

$(GPIO_OBJ) : $(GPIO_SRC)
	$(CC) $(CFLAGS) $< -o $@

$(SYSTICK_OBJ) : $(SYSTICK_SRC)
	$(CC) $(CFLAGS) $< -o $@

$(TRANSMISSION_OBJ) : $(TRANSMISSION_SRC)
	$(CC) $(CFLAGS) $< -o $@

## Link
$(TARGET_ELF) : $(STARTUP_OBJ) $(GPIO_OBJ) $(SYSTICK_OBJ) $(TRANSMISSION_OBJ) $(MAIN_OBJ)
	$(CC) $(LDFLAGS) $^ -o $@
