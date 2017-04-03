.equ ADDR_CHAR, 0x09000000
.text
.global Init
Init:
subi sp, sp, 4
stw ra, 0(sp)

movia r2, CURSOR_POS
movia r3, ADDR_CHAR
stw r3, 0(r2) #initial CURSOR_POS is 0x09000000, position (0,0) on VGA

call PS2_Init

call Timer_Init

#call VGA_Init 

addi r8, r0, 1
wrctl ctl0, r8 #enable PIE bit

ldw ra, 0(sp)
addi sp, sp, 4
ret
.end