.include "defines.h"
.text
.global goto_statement
#function: execute goto statement
goto_statement:
subi sp, sp, 4
stw ra, 0(sp)

movi r4, GOTO_TOKEN
call accept_token

call tokenize_num
mov r4, r2
call jump_to_line

ldw ra, 0(sp)
addi sp, sp, 4
ret