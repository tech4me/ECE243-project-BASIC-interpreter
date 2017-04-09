.include "defines.h"
.text
.global let_statement
#function: execute let statement
let_statement:
subi sp, sp, 8
stw ra, 0(sp)
stw r16, 4(sp)

call get_variable_num
mov r16, r2

movi r4, VARIABLE_TOKEN
call accept_token
movi r4, EQ_TOKEN
call accept_token

call expression
mov r4, r16
mov r5, r2
call set_variable

movi r4, LF_TOKEN
call accept_token

ldw ra, 0(sp)
ldw r16, 4(sp)
addi sp, sp, 8
ret