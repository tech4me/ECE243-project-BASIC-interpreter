.text
#function: check if the current_token is the same as the expected token, if not report error and stop the program
#parameter: r4: expected token
.global accept_token
accept_token:
subi sp, sp, 8
stw ra, 0(sp)
stw r16, 4(sp)

movia r16, current_token
ldw r16, 0(r16)
bne r16, r4, wrong_token
#print got expected token
call tokenize_next
br accept_token_end

wrong_token:
#exit program and clear buffer / report error
#############################################
#############################################
#############################################
#br to inf loop

accept_token_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
addi sp, sp, 8
ret