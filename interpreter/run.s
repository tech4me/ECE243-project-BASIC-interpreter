.text
.global run
#function: run the interpreter on a program
#parameter: r4: pointer to the program
run:
subi sp, sp, 4
stw ra, 0(sp)
call interpreter_init #init with the program pointer

keep_running:
call run_interpreter
call is_tokenize_finished
bne r2, r0, run_end
br keep_running

run_end:
#print end message
ldw ra, 0(sp)
addi sp, sp, 4
ret