.text
.global print_statement
#function: execute print statement
print_statement:
subi sp, sp, 4
stw ra, 0(ra)

#accept print token
movi r4, PRINT_TOKEN
call accept_token

movia r16, current_token
print_loop:
ldw r17, 0(r16) #get the next token
movi r18, STRING_TOKEN
beq r17, r18, print_string
movi r18, COMMA_TOKEN
beq r17, r18, print_space
movi r18, SEMICOLON_TOKEN
beq r17, r18, print_nothing
movi r18, VARIABLE_TOKEN
beq r17, r18, print_number
movi r18, NUM_TOKEN
beq r17, r18, print_number
br print_statement_end
while_loop:
movi r18, LF_TOKEN
beq r17, r18, print_statement_end
movi r18, EOF_TOKEN
beq r17, r18, print_statement_end
br print_loop

print_string:

br while_loop

print_space:

br while_loop

print_nothing:

br while_loop

print_statement_end:

call tokenize_next

ldw ra, 0(ra)
addi sp, sp, 4
ret