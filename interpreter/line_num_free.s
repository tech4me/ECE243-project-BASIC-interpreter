.include "defines.h"
.text
.global line_num_free
#function: clear the line number array by setting all the legal word to 0
line_num_free:
movia r8, line_index_head
ldw r9, 0(r8)
movi r10, MAX_LINE_NUM
loop:
beq r10, r0, finish_free
stw r0, 0(r9)
addi r9, r9, 12
subi r10, r10, 1
br loop
finish_free:
#reset current line number
movia r8, line_index_head
ldw r9, 0(r8)
movia r8, line_index_current
stw r9, 0(r8)
ret