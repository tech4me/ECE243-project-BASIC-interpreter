.include "defines.h"
.text
.global line_statement
line_statement:
subi sp, sp, 8
stw ra, 0(sp)
stw r16, 4(sp)
#print line number to debug screen
call tokenize_num
mov r16, r2
call tokenize_pos
mov r5, r2
mov r4, r16
call add_line_index
movi r4, NUM_TOKEN
call accept_token
call statement
ldw ra, 0(sp)
ldw r16, 4(sp)
addi sp, sp, 8
ret