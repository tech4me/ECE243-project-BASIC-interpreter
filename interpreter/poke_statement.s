.include "defines.h"

.data
ERROR_MSG:
.string "Unrecognized address token!"

.text
.global poke_statement
#function: execute poke statement
poke_statement:
subi sp, sp, 8
stw ra, 0(sp)
stw r16, 4(sp)

movi r4, POKE_TOKEN
call accept_token

movia r4, current_token
ldw r4, 0(r4)
movi r5, LED_ADDR_TOKEN
beq r4, r5, LED_ADDR_TOKEN_ACCEPT
br error

LED_ADDR_TOKEN_ACCEPT:
movia r16, LED_ADDRESS
movi r4, LED_ADDR_TOKEN
call accept_token

movi r4, COMMA_TOKEN
call accept_token

call expression
stwio r2, 0(r16)

movi r4, LF_TOKEN
call accept_token

poke_statement_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
addi sp, sp, 8
ret

error:
movia r4, ERROR_MSG
call print_to_debug
br poke_statement_end