.include "defines.h"

.text
.global poke_statement
#function: execute poke statement
poke_statement:
subi sp, sp, 12
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)

movi r4, POKE_TOKEN
call accept_token

call expression
mov r17, r2

movi r4, COMMA_TOKEN
call accept_token

call expression
stwio r2, 0(r17)

movi r4, LF_TOKEN
call accept_token

poke_statement_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
addi sp, sp, 12
ret