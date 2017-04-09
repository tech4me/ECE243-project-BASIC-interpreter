.include "defines.h"
.text
.global expression
#function: solve for the following expression
expression:
subi sp, sp, 16
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)
stw r18, 12(sp)

call term
mov r16, r2
movia r18, current_token
ldw r18, 0(r18) #get the current token

while_loop:
movi r3, PLUS_TOKEN
beq r18, r3, process
movi r3, MINUS_TOKEN
beq r18, r3, process
movi r3, AND_TOKEN
beq r18, r3, process
movi r3, OR_TOKEN
beq r18, r3, process
br expression_end

process:
call tokenize_next
call term
mov r17, r2

movi r3, PLUS_TOKEN
beq r18, r3, process_plus
movi r3, MINUS_TOKEN
beq r18, r3, process_minus
movi r3, AND_TOKEN
beq r18, r3, process_and
movi r3, OR_TOKEN
beq r18, r3, process_or

finish_process:

movia r18, current_token
ldw r18, 0(r18) #get the current token
br while_loop

expression_end:
mov r2, r16

ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
ldw r18, 12(sp)
addi sp, sp, 16
ret

process_plus:
add r16, r16, r17
br finish_process

process_minus:
sub r16, r16, r17
br finish_process

process_and:
and r16, r16, r17
br finish_process

process_or:
or r16, r16, r17
br finish_process