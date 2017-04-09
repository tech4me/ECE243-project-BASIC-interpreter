.include "defines.h"
.text
.global term
#function: handle and process term in expressions
#return: r2: the value of the term
term:
subi sp, sp, 16
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)
stw r18, 12(sp)

call factor
mov r16, r2
movia r18, current_token
ldw r18, 0(r18) #get the current token

while_loop:
movi r3, ASTR_TOKEN
beq r18, r3, process
movi r3, SLASH_TOKEN
beq r18, r3, process
movi r3, MOD_TOKEN
beq r18, r3, process
br term_end

process:
call tokenize_next
call factor
mov r17, r2

movi r3, ASTR_TOKEN
beq r18, r3, process_multiply
movi r3, SLASH_TOKEN
beq r18, r3, process_devide
movi r3, MOD_TOKEN
beq r18, r3, process_mod

finish_process:
movia r18, current_token
ldw r18, 0(r18) #get the current token
br while_loop

term_end:
mov r2, r16

ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
ldw r18, 12(sp)
addi sp, sp, 16
ret

process_multiply:
mul r16, r16, r17
br finish_process

process_devide:
div r16, r16, r17
br finish_process

process_mod:
div r3, r16, r17
mul r3, r3, r17
sub r16, r16, r3
br finish_process