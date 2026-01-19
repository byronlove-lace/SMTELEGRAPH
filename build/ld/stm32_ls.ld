ENTRY(Reset_Handler)

/* Available Memory */
MEMORY
{
  FLASH(rx) :ORIGIN = 0x08000000,LENGTH =512K
  SRAM(rwx) :ORIGIN = 0x20000000,LENGTH =128K
}

/* Stack pointer init to end of SRAM (max address space - works down stack)*/
_estack = ORIGIN(SRAM) +LENGTH(SRAM);

/* Heap and Stack Sizes */
__max_heap_size = 0x200;
__max_stack_size = 0x400;

/* Output Sections */
SECTIONS
{
  .text :
  {
    . = ALIGN(4); /*allign start and end of section to 4byte boundary*/
    *(.isr_vector_tbl) /*merge all isr vectors from input files*/
    *(.text)
    *(.rodata)
    . = ALIGN(4);
    _etext = .; /*global symbol for end of text section*/
  }>FLASH

  .data :
  {
    . = ALIGN(4);
    _sdata = .; /*pointer to start of data section for startup file*/
    *(.data)
    . = ALIGN(4);
    _edata = .; /*Q: Why is edata outside allign?*/
  } > SRAM AT> FLASH /*>(vma) AT (lma) // init data from flash but allow rt rw */

  .bss :
  {
    . = ALIGN(4);
    _sbss = .;
    *(.bss)
    . = ALIGN(4);
    _ebss = .;
  } > SRAM
}
