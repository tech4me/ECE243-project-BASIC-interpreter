.text
.global interpreter_end
#function: to see if the interpreter should finish
interpreter_end:
subi sp, sp, 4
stw ra, 0(sp)

movia r2, end_flag
ldw r2, 0(r2)
bne r0, r2, return_true
call is_tokenize_finished
bne r0, r2, return_true
mov r2, r0
br end

return_true:
movi r2, 1

end:
ldw ra, 0(sp)
addi sp, sp, 4
ret