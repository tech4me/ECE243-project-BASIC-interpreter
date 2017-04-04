.include "defines.h"
.text
.global find_line_index
#function: try to find the input line number in the array, if found return pointer to program, if not return null
#parameter: r4: line number
#return: r2: pointer to the program at that line
find_line_index:
movia r8, line_index_head
ldw r8, 0(r8) #r8 has the start address of the line number struct array
mov r2, r0 #return null if not found
movi r9, MAX_LINE_NUM

loop:
beq r9, r0, find_line_index_end
ldw r10, 0(r8) #the legal word
beq r10, r0, find_line_index_end
ldw r10, 4(r8) #the line number word
beq r10, r4, found_line_number
addi r8, r8, 12
subi r9, r9, 1
br loop

found_line_number:
ldw r2, 8(r8)
find_line_index_end:
ret