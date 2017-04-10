.include "defines.h"
.text
.global jump_to_line_slow
#function: find the line number even when it has not been indexed
#parameter r4: line number to jump to
jump_to_line_slow:
subi sp, sp, 16
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)
stw r18, 12(sp)

mov r18, r4

movia r4, INPUT_BUF
call tokenize_goto
mov r16, r2

movia r17, current_token

outer_while:
call tokenize_num
beq r18, r2, finish_loop
outer_do_while:
inner_do_while:

call tokenize_next

ldw r16, 0(r17) #get the next token
movi r2, LF_TOKEN
beq r16, r2, exit_inner_do_while
movi r2, EOF_TOKEN
beq r16, r2, exit_inner_do_while
br inner_do_while
exit_inner_do_while:

ldw r16, 0(r17) #get the next token
movi r2, LF_TOKEN
bne r16, r2, do_not_get_next_token
call tokenize_next
do_not_get_next_token:

ldw r16, 0(r17) #get the next token
movi r2, NUM_TOKEN
bne r16, r2, outer_do_while

br outer_while

finish_loop:

ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
ldw r18, 12(sp)
addi sp, sp, 16
ret