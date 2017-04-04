.text
.global add_line_index
#function: add the line to the line index structure
#parameter: r4: line number
#parameter: r5: pointer to the character
add_line_index:
subi sp, sp, 4
stw ra, 0(sp)

call find_line_index
beq r2, r0, line_dne
br add_line_index_end
line_dne:
movia r8, line_index_current
ldw r10, 0(r8)
movi r9, 1
stw r9, 0(r10) #set legal
stw r4, 4(r10) #set line index number
stw r5, 8(r10) #set pointer to program

#advance the line_index_current
addi r10, r10, 12
stw r10, 0(r8)

add_line_index_end:
ldw ra, 0(sp)
addi sp, sp, 4
ret