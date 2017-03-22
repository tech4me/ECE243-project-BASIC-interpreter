.text
.global Init
Init:
subi sp, sp, 4
stw ra, 0(sp)

call PS2_Init

addi r8, r0, 1
wrctl ctl0, r8 #enable PIE bit

ldw ra, 0(sp)
addi sp, sp, 4
ret
.end