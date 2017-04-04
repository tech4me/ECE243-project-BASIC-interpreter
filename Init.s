.include "defines.h"
.equ ADDR_CHAR, 0x09000000
.text
.global Init
Init:
subi sp, sp, 4
stw ra, 0(sp)

movia r2, CURSOR_POS
movia r3, ADDR_CHAR
stw r3, 0(r2) #initial CURSOR_POS is 0x09000000, position (0,0) on VGA

#Reset ptr and next_ptr position
#movia r2, ptr
#movia r3, INPUT_BUF
#stw r3, 0(r2)
#movia r2, next_ptr
#stw r3, 0(r2)

#Reset default token
#movia r2, current_token
#movi r3, ERROR_TOKEN
#stw r3, 0(r2)

call PS2_Init

call Timer_Init

#call VGA_Init 

addi r8, r0, 1
wrctl ctl0, r8 #enable PIE bit

ldw ra, 0(sp)
addi sp, sp, 4
ret
.end