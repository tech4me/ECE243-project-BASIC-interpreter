.include "defines.h"

.data
ERROR_MSG:
.string "Unable to find matching FOR statement!"

.text
.global next_statement
#function: execute next statement
next_statement:
subi sp, sp, 12
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)

movi r4, NEXT_TOKEN
call accept_token

call get_variable_num
mov r16, r2

movi r4, VARIABLE_TOKEN
call accept_token

movia r17, FOR_STACK_INDEX
ldw r17, 0(r17)
bgt r17, r0, check_var
br error
check_var:
subi r17, r17, 1
muli r17, r17, 12
movia r2, FOR_STACK
add r17, r17, r2
ldw r2, 4(r17)
beq r2, r16, stack_good
br error

stack_good:
mov r4, r16
call get_variable
mov r4, r16
addi r5, r2, 1

subi sp, sp, 4
stw r5, 0(sp)
call set_variable
ldw r5, 0(sp)
addi sp, sp, 4

ldw r2, 8(r17)
blt r5, r2, jump_back

movia r17, FOR_STACK_INDEX #FOR_STACK_INDEX--
ldw r2, 0(r17)
subi r2, r2, 1
stw r2, 0(r17)
movi r4, LF_TOKEN
call accept_token
br next_statement_end

jump_back:
ldw r4, 0(r17)
call jump_to_line
br next_statement_end

next_statement_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
addi sp, sp, 12
ret

error:
movia r4, ERROR_MSG
call print_to_debug
movi r4, LF_TOKEN
call accept_token
br next_statement_end