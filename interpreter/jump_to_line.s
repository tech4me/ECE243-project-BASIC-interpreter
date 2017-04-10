.text
.global jump_to_line
#function: jump to certain line number
#parameter: r4: line number to jump to
jump_to_line:
subi sp, sp, 4
stw ra, 0(sp)

call find_line_index

beq r2, r0, unindexed_line
mov r4, r2
call tokenize_goto
br jump_to_line_end
unindexed_line:
call jump_to_line_slow
jump_to_line_end:
ldw ra, 0(sp)
addi sp, sp, 4
ret