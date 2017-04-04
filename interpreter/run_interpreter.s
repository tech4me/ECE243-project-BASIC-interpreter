.text
.global run_interpreter
run_interpreter:
subi sp, sp, 4
stw ra, 0(sp)
call is_tokenize_finished
bne r2, r0, program_finished
call line_statement
br run_interpreter_end

program_finished:
#print debug msg when program finish execute

run_interpreter_end:
ldw ra, 0(sp)
addi sp, sp, 4
ret