.data
.global end_flag
end_flag:
.word 0

.text
.global interpreter_Init
#function: initialize the interpreter
#parameter: r4: pointer to the program to start
interpreter_Init:
subi sp, sp, 12
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)
mov r17, r4
#reset program for loop stack and subroutine stack
#Clear line index array
call line_num_free
#set peek and poke function
movia r16, end_flag
stw r0, 0(r16) #reset end_flag
mov r4, r17
call tokenize_goto
ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
addi sp, sp, 12
ret