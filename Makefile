# Compiler and Linker Settings
CC = gcc
CFLAGS = -mcpu=cortex-m4 -mthumb -std=c11 -Wall -Wextra -O2 -g -fstack-protector-all -DSTM32F411xE -DUSE_HAL_DRIVER -DARM_MATH_CM4 \
        -ffunction-sections -fdata-sections -fno-common -MMD -MP -D__ARM_ARCH_7M__ -D__ARM_ACLE__ 
LDFLAGS = -Tstm32f411xe.ld -L/path/to/stm32f411/lib -ffunction-sections -fdata-sections

# Paths to STM32F411 includes and libraries
INCLUDES = -I/path/to/stm32f411/include
LIBS = -L/path/to/stm32f411/lib

# Source and Object Files
SRC = main.c
OBJ = $(SRC:.c=.o)

# Output Binary and ELF Executables
TARGET_ELF = main.elf
TARGET_BIN = main.bin

# Toolchain (if needed)
OBJCOPY = arm-none-eabi-objcopy

# Compiler flags for safety and optimization
CFLAGS += $(INCLUDES)

# Default Target: Compile and Link the Program
all: $(TARGET_ELF) $(TARGET_BIN)

# Link the object files into the ELF executable
$(TARGET_ELF): $(OBJ)
	$(CC) $(OBJ) $(LDFLAGS) -o $@

# Convert ELF to Binary for Flashing
$(TARGET_BIN): $(TARGET_ELF)
	$(OBJCOPY) -O binary $(TARGET_ELF) $(TARGET_BIN)

# Compile C source files into object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Include the dependency files
-include $(OBJ:.o=.d)

# Clean the build
clean:
	rm -f $(OBJ) $(TARGET_ELF) $(TARGET_BIN) $(OBJ:.o=.d)

# Flash the binary to STM32 (using OpenOCD or another tool)
flash: $(TARGET_BIN)
	openocd -f interface/stlink-v2.cfg -f target/stm32f4x.cfg -c "program $(TARGET_BIN) verify reset exit"

.PHONY: all clean flash

