.include "defines.h"
.text
.global print_statement
#function: execute print statement
print_statement:
subi sp, sp, 16
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)
stw r18, 12(sp)

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
call tokenize_string
movia r4, PRINT_STRING_BUF
call print_to_output
#clear PRINT_STRING_BUF
stb r0, 0(r4)
call tokenize_next
br while_loop

print_space:
movia r4, PRINT_STRING_BUF
movi r5, ' '
stb r5, 0(r4)
stb r0, 1(r4)
call print_to_output
#clear PRINT_STRING_BUF
stb r0, 0(r4)
call tokenize_next
br while_loop

print_nothing:
call tokenize_next
br while_loop

print_number:
call expression
mov r4, r2
movia r5, PRINT_STRING_BUF
movi r6, 10
call itoa
movia r4, PRINT_STRING_BUF
call print_to_output
#clear PRINT_STRING_BUF
stb r0, 0(r4)
br while_loop

print_statement_end:

call tokenize_next

ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
ldw r18, 12(sp)
addi sp, sp, 16
ret