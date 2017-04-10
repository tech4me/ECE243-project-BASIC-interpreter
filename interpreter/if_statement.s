.include "defines.h"
.text
.global if_statement
#function: execute if statement
if_statement:
subi sp, sp, 12
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)

movi r4, IF_TOKEN
call accept_token

call relation
mov r17, r2

movi r4, THEN_TOKEN
call accept_token

bne r17, r0, if_case
do_while:
call tokenize_next
movia r16, current_token
ldw r16, 0(r16)
movi r2, ELSE_TOKEN
beq r16, r2, exit_do_while
movi r2, LF_TOKEN
beq r16, r2, exit_do_while
movi r2, EOF_TOKEN
beq r16, r2, exit_do_while
br do_while
exit_do_while:

movia r16, current_token
ldw r16, 0(r16)
movi r2, ELSE_TOKEN
beq r16, r2, else_case
movi r2, LF_TOKEN
beq r16, r2, only_if_case

if_statement_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
addi sp, sp, 12
ret

if_case:
call statement
br if_statement_end

else_case:
call tokenize_next
call statement
br if_statement_end

only_if_case:
call tokenize_next
br if_statement_end