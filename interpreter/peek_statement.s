.include "defines.h"

.text
.global peek_statement
#function: execute peek statement
peek_statement:
subi sp, sp, 12
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)

movi r4, PEEK_TOKEN
call accept_token

call expression
mov r17, r2

movi r4, COMMA_TOKEN
call accept_token

call get_variable_num
mov r16, r2

movi r4, VARIABLE_TOKEN
call accept_token

movi r4, LF_TOKEN
call accept_token

ldwio r5, 0(r17)

mov r4, r16
call set_variable

peek_statement_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
addi sp, sp, 12
ret