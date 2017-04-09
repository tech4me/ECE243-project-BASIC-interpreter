.include "defines.h"
.text
.global relation
#function: handles relationship expressions such as less than, greater than
#return: r2: the result of the comparison
relation:
subi sp, sp, 16
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)
stw r18, 12(sp)

call expression
mov r16, r2
movia r18, current_token
ldw r18, 0(r18) #get the current token

while_loop:
movi r3, LT_TOKEN
beq r18, r3, process
movi r3, GT_TOKEN
beq r18, r3, process
movi r3, EQ_TOKEN
beq r18, r3, process
br relation_end

process:
call tokenize_next
call expression
mov r17, r2

movi r3, LT_TOKEN
beq r18, r3, process_lessthan
movi r3, GT_TOKEN
beq r18, r3, process_greaterthan
movi r3, EQ_TOKEN
beq r18, r3, process_equal

finish_process:
movia r18, current_token
ldw r18, 0(r18) #get the current token
br while_loop

relation_end:
mov r2, r16

ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
ldw r18, 12(sp)
addi sp, sp, 16
ret

process_lessthan:
cmplt r16, r16, r17
br finish_process

process_greaterthan:
cmpgt r16, r16, r17
br finish_process

process_equal:
cmpeq r16, r16, r17
br finish_process