.include "defines.h"

.data
ERROR_MSG:
.string "Unable to find matching GOSUB statement!"

.text
.global return_statement
#function: execute return statement
return_statement:
subi sp, sp, 4
stw ra, 0(sp)

movi r4, RETURN_TOKEN
call accept_token

movia r4, GOSUB_STACK_INDEX
ldw r4, 0(r4)
bgt r4, r0, return
movia r4, ERROR_MSG
call print_to_debug
br return_statement_end

return:
movia r6, GOSUB_STACK_INDEX
ldw r4, 0(r6)
movia r5, GOSUB_STACK
subi r4, r4, 1
stw r4, 0(r6)
slli r4, r4 ,2
add r4, r5, r4
ldw r4, 0(r4)
call jump_to_line

return_statement_end:
ldw ra, 0(sp)
addi sp, sp, 4
ret