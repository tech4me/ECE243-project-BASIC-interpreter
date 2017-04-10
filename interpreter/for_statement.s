.include "defines.h"
.data
.align 2
.global FOR_STACK_INDEX
FOR_STACK_INDEX:
.word 0

.global FOR_STACK
FOR_STACK:
.word 0 #line number after the for loop
.word 0 #variable number of the for loop
.word 0 #the end condtion of the loop
.skip 3*4*5

ERROR_MSG:
.string "For stack overflowed, cannot have this many for loops!"

.text
.global for_statement
#function: execute for statement
for_statement:
subi sp, sp, 20
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)
stw r18, 12(sp)
stw r19, 16(sp)

movi r4, FOR_TOKEN
call accept_token

call get_variable_num
mov r16, r2

movi r4, VARIABLE_TOKEN
call accept_token

movi r4, EQ_TOKEN
call accept_token

call expression

mov r4, r16
mov r5, r2
call set_variable

movi r4, TO_TOKEN
call accept_token

call expression
mov r17, r2

movi r4, LF_TOKEN
call accept_token

movia r2, FOR_STACK_INDEX
ldw r2, 0(r2)
movi r3, MAX_FOR_STACK_SIZE
bge r2, r3, for_stack_overflow

movia r2, FOR_STACK_INDEX
ldw r18, 0(r2)

movia r19, FOR_STACK
muli r18, r18, 12
add r19, r19, r18

call tokenize_num
stw r2, 0(r19)
stw r16, 4(r19)
stw r17, 8(r19)

movia r2, FOR_STACK_INDEX
ldw r18, 0(r2)
addi r18, r18, 1
stw r18, 0(r2)

for_statement_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
ldw r18, 12(sp)
ldw r19, 16(sp)
addi sp, sp, 20
ret

for_stack_overflow:
movia r4, ERROR_MSG
call print_to_debug
br for_statement_end