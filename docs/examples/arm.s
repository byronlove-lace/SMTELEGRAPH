EQU GPIOA_MODER, 0x40020000 ; Var assignment
EQU RCC_AHB1ENR, 0x40023800
; Enable clock for GPIOA
LDR R0, =RCC_AHB1ENR ; LDR = Load Register
LDR R1, [R0]
ORR R1, R1, #(1 << 0) ; # =! Comment: Immediate Value Indicator // ORR = Bitwise OR
STR R1, [R0]
