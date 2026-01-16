
bin/main.o:     file format elf32-littlearm

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000040  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00000000  00000000  00000000  00000074  2**0
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  00000000  00000000  00000074  2**0
                  ALLOC
  3 .comment      00000024  00000000  00000000  00000074  2**0
                  CONTENTS, READONLY
  4 .ARM.attributes 0000002e  00000000  00000000  00000098  2**0
                  CONTENTS, READONLY

Disassembly of section .text:

00000000 <main>:
   0:	b480      	push	{r7}
   2:	af00      	add	r7, sp, #0
   4:	4b0c      	ldr	r3, [pc, #48]	@ (38 <main+0x38>)
   6:	6b1b      	ldr	r3, [r3, #48]	@ 0x30
   8:	4a0b      	ldr	r2, [pc, #44]	@ (38 <main+0x38>)
   a:	f043 0301 	orr.w	r3, r3, #1
   e:	6313      	str	r3, [r2, #48]	@ 0x30
  10:	4b0a      	ldr	r3, [pc, #40]	@ (3c <main+0x3c>)
  12:	681b      	ldr	r3, [r3, #0]
  14:	4a09      	ldr	r2, [pc, #36]	@ (3c <main+0x3c>)
  16:	f443 6380 	orr.w	r3, r3, #1024	@ 0x400
  1a:	6013      	str	r3, [r2, #0]
  1c:	4b07      	ldr	r3, [pc, #28]	@ (3c <main+0x3c>)
  1e:	681b      	ldr	r3, [r3, #0]
  20:	4a06      	ldr	r2, [pc, #24]	@ (3c <main+0x3c>)
  22:	f463 6300 	orn	r3, r3, #2048	@ 0x800
  26:	6013      	str	r3, [r2, #0]
  28:	4b04      	ldr	r3, [pc, #16]	@ (3c <main+0x3c>)
  2a:	695b      	ldr	r3, [r3, #20]
  2c:	4a03      	ldr	r2, [pc, #12]	@ (3c <main+0x3c>)
  2e:	f043 0320 	orr.w	r3, r3, #32
  32:	6153      	str	r3, [r2, #20]
  34:	e7f8      	b.n	28 <main+0x28>
  36:	bf00      	nop
  38:	40023800 	.word	0x40023800
  3c:	40020000 	.word	0x40020000
