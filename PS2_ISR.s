.equ PS2_Controller, 0xFF200100
.text
.global PS2_ISR
PS2_ISR:
movia r8, PS2_Controller
WAIT_FOR_PS2:
ldwio r9, 0(r8)
movia r10, 0xFFFF0000
and r10, r10, r9
srli r10, r10, 0x10
beq r10, r0, WAIT_FOR_PS2
andi r9, r9, 0xFF
movi r10, 0xE1
beq r9, r10, E1_IGNORE #should ignore the rest
movi r10, 0xE0
beq r9, r10, E0_READ_MORE #should read more
movi r10, 0xF0
beq r9, r10, F0_IGNORE #should ignore the rest
#The rest can directly save
movia r10, INPUT_BUF_PTR
ldw r10, 0(r10)
movia r11, CHAR_COUNT
ldw r12, 0(r11)
add r10, r10, r12
stb r9, 0(r10)
addi r12, r12, 1
stw r12, 0(r11) #save the new count back
br END

E1_IGNORE:
ldwio r9, 0(r8)
movia r10, 0xFFFF0000
and r10, r9, r10
srli r10, r10, 0x10
beq r10, r0, F0_IGNORE #ignore everything in FIFO
br END

E0_READ_MORE:
ldwio r9, 0(r8)
andi r9, r9, 0xFF
movi r10, 0xF0
beq r9, r10, F0_IGNORE #should ignore the rest
######
#case should be added for arrow keys
######
br END

F0_IGNORE:
ldwio r9, 0(r8)
movia r10, 0xFFFF0000
and r10, r9, r10
srli r10, r10, 0x10
beq r10, r0, F0_IGNORE #ignore everything in FIFO

END:
ret
.end