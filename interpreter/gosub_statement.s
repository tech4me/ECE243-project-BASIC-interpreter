.include "defines.h"
.data
.align 2
.global GOSUB_STACK_INDEX
GOSUB_STACK_INDEX:
.word 0

.global GOSUB_STACK
GOSUB_STACK:
.skip MAX_GOSUB_STACK_SIZE * 4

ERROR_MSG:
.string "For stack overflowed, cannot have this many for loops!"

.text
.global gosub_statement
#function: execute gosub statement
gosub_statement:
subi sp, sp, 8
stw ra, 0(sp)
stw r16, 4(sp)

movi r4, GOSUB_TOKEN
call accept_token

call tokenize_num
mov r16, r2

movi r4, NUM_TOKEN
call accept_token

movi r4, LF_TOKEN
call accept_token

movia r4, GOSUB_STACK_INDEX
movi r2, MAX_GOSUB_STACK_SIZE
ldw r4, 0(r4)
blt r4, r2, goto_sub
br error

goto_sub:
call tokenize_num
movia r4, GOSUB_STACK_INDEX
ldw r4, 0(r4)
slli r4, r4, 2
movia r5, GOSUB_STACK
add r4, r5, r4
stw r2, 0(r4)

movia r5, GOSUB_STACK_INDEX
ldw r4, 0(r5)
addi r4, r4, 1
stw r4, 0(r5)

mov r4, r16
call jump_to_line

gosub_statement_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
addi sp, sp, 8
ret

error:
movia r4, ERROR_MSG
call print_to_debug
br gosub_statement_end