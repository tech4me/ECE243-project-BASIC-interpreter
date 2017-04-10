.include "defines.h"
.text
.global end_statement
#function: execute end statement
end_statement:
subi sp, sp, 4
stw ra, 0(sp)

movi r4, END_TOKEN
call accept_token

movia r2, end_flag #set end flag to true
movi r3, 1
stw r3, 0(r2)

ldw ra, 0(sp)
addi sp, sp, 4
ret