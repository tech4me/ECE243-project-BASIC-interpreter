.include "defines.h"

.data
ERROR_MSG:
.string "Unrecognized address token!"

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

movia r4, current_token
ldw r4, 0(r4)
movi r5, SW_ADDR_TOKEN
beq r4, r5, SW_ADDR_TOKEN_ACCEPT
movi r5, GPIO0_ADDR_TOKEN
beq r4, r5, GPIO0_ADDR_TOKEN_ACCEPT
br error

SW_ADDR_TOKEN_ACCEPT:
movia r4, SW_ADDRESS
ldwio r17, 0(r4)
movi r4, SW_ADDR_TOKEN
call accept_token
br keep_going

GPIO0_ADDR_TOKEN_ACCEPT:
movia r4, GPIO0_ADDRESS
ldwio r17, 0(r4)
movi r4, GPIO0_ADDR_TOKEN
call accept_token

keep_going:
movi r4, COMMA_TOKEN
call accept_token

call get_variable_num
mov r16, r2

movi r4, VARIABLE_TOKEN
call accept_token

movi r4, LF_TOKEN
call accept_token

mov r4, r16
mov r5, r17
call set_variable

peek_statement_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
addi sp, sp, 12
ret

error:
movia r4, ERROR_MSG
call print_to_debug
br peek_statement_end