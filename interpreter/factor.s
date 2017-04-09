.include "defines.h"
.data
ERROR_MSG:
.string "Factor unrecognized input! Exit!\n"

.text
.global factor
#function: handle factors in expression such as numbers, brackets and variables
#return: r2: the value of the current factor
factor:
subi sp, sp, 4
stw ra, 0(sp)

movia r4, current_token
ldw r4, 0(r4) #get the current token
movi r5, NUM_TOKEN
beq r4, r5, NUMBER
movi r5, LEFTPAREN_TOKEN
beq r4, r5, LEFTPAREN
movi r5, VARIABLE_TOKEN
beq r4, r5, VARIABLE
mov r2, r0
br factor_end

NUMBER:
call tokenize_num
subi sp, sp, 4
stw r2, 0(sp)
movi r4, NUM_TOKEN
call accept_token
ldw r2, 0(sp)
addi sp, sp, 4
br factor_end

LEFTPAREN:
movi r4, LEFTPAREN_TOKEN
call accept_token
call expression
subi sp, sp, 4
stw r2, 0(sp)
movi r4, RIGHTPAREN_TOKEN
call accept_token
ldw r2, 0(sp)
addi sp, sp, 4
br factor_end

VARIABLE:
call variable_factor
br factor_end

ERROR:
movia r4, ERROR_MSG
call print_to_debug

factor_end:
ldw ra, 0(sp)
addi sp, sp, 4
ret