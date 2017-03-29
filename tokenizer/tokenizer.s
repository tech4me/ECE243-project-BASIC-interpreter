.include "tokenids.h"

.data
PRINT_STRING_BUF:
.skip MAX_STRING_LENGTH
.text
.equ MAX_STRING_LENGTH, 40
.equ MAX_NUMBER_LENGTH, 6
.global get_next_token
#function: determine the type of the next token
#return: r2: the token type
get_next_token:
subi sp, sp, 24
stw r16, 0(sp)
stw r17, 4(sp)
stw r18, 8(sp)
stw r19, 12(sp)
stw r20, 16(sp)
stw ra, 20(sp)

movia r18, ptr
movia r19, next_ptr
ldw r17, 0(r18)
ldb r17, 0(r17)
bne r17, r0, not_eof
movi r2, EOF_TOKEN
br get_next_token_end
not_eof:
mov r4, r17
call isdigit
beq r2, r0, not_a_number
#if we are looking at a number
mov r20, r0
ldw r17, 0(r18)
number_for_loop:
movi r2, MAX_NUMBER_LENGTH
bge r20, r2, number_length_too_long
addi r20, r20, 1

add r4, r17, r20
ldb r4, 0(r4)
call isdigit
bne r2, r0, number_for_loop

add r16, r17, r20
stw r16, 0(r19) #nextptr = ptr + i
movi r2, NUM_TOKEN
br get_next_token_end

#number_continue:
#add r4, r17, r20
#ldb r4, 0(r4)
#call isdigit
#beq r2, r0, number_for_loop
#movi r2, ERROR_TOKEN
#br get_next_token_end

number_length_too_long:
movi r2, ERROR_TOKEN
br get_next_token_end

not_a_number:
call singlechar
beq r2, r0, not_a_singlechar
#if we are looing at a singlechar
ldw r16, 0(r18)
addi r16, r16, 1
stw r16, 0(r19)
br get_next_token_end

not_a_singlechar:
movi r16, '"'
bne r17, r16, not_a_string
ldw r16, 0(r18)
stw r16, 0(r19)
find_end_quote:
addi r16, r16, 1
stw r16, 0(r19)
ldb r17, 0(r16)
movi r2, '"'
bne r17, r2, find_end_quote
addi r16, r16, 1
stw r16, 0(r19)
movi r2, STRING_TOKEN
br get_next_token_end

not_a_string:
#to see if this is a keyword token
movia r16, KEYWORD_TOKEN
movia r20, KEYWORD_ERROR #the end condition of the for loop
keyword_loop:
beq r16, r20, not_keyword
ldw r17, 0(r16)
mov r4, r17 #calculate the length of the current token string
call strlen
mov r6, r2 #pass the length as paramter to strncmp
ldw r4, 0(r18) #put ptr to r4 for strncmp
mov r5, r17 #pointer to string token
call strncmp
bne r2, r0, try_next_string_token
mov r4, r17 #calculate the length of the current token string
call strlen
ldw r17, 0(r18)
add r2, r2, r17
stw r2, 0(r19)
ldw r2, 4(r16) #load the return token into r2
br get_next_token_end

try_next_string_token:
addi r16, r16, 8 #move r16 to point to the next string and token pair
br keyword_loop

not_keyword:
ldw r16, 0(r18) #ptr
ldb r17, 0(r16) #*ptr
movi r2, 'A'
blt r17, r2, not_variable
movi r2, 'Z'
bgt r17, r2, not_variable
addi r2, r16, 1
stw r2, 0(r19)
movi r2, VARIABLE_TOKEN
br get_next_token_end

not_variable:
mov r2, r0 #error token if doesn't go into any of the case

get_next_token_end:
ldw r16, 0(sp)
ldw r17, 4(sp)
ldw r18, 8(sp)
ldw r19, 12(sp)
ldw r20, 16(sp)
ldw ra, 20(sp)
addi sp, sp, 24
ret

.global tokenize_next
#function: tokenize the next token
tokenize_next:
subi sp, sp, 12
stw r16, 0(sp)
stw r17, 4(sp)
stw ra, 8(sp)

call is_tokenize_finished
bne r2, r0, tokenize_next_end dont't read next token if already finished the file
movia r16, ptr
movia r17, next_ptr
ldw r2, 0(r17)
stw r2, 0(r16) #ptr = next_ptr

#ignore white spaces
movi r3, ' '
ignore_white_space:
ldb r17, 0(r2)
bne r17, r3, ready_for_token
addi r2, r2, 1 # ++ptr
br ignore_white_space

ready_for_token:
stw r2, 0(r16) #save new ptr
call get_next_token
movia r16, current_token
stw r2, 0(r16) #update new current token

#if token is REM ignore the current line
movi r3, REM_TOKEN
bne r2, r3, tokenize_next_end #if not REM keep going

#go through comments until the final \n
movia r17, next_ptr
LOOP_UNTIL_CR:
ldw r16, 0(r17)
ldb r16, 0(r16)
movi r3, '\n'
beq r16, r3, rem_get_next_token
call is_tokenize_finished
bne r2, r0, rem_get_next_token
ldw r16, 0(r17)
addi r16, r16, 1
stw r16, 0(r17)
br LOOP_UNTIL_CR

rem_get_next_token:
call tokenize_next

tokenize_next_end:
ldw r16, 0(sp)
ldw r17, 4(sp)
ldw ra, 8(sp)
addi sp, sp, 12
ret

.global tokenize_string
#function: save string into a buffer for print statements
tokenize_string:
subi sp, sp, 12
stw r16, 0(sp)
stw r17, 4(sp)
stw ra, 8(sp)
movia r16, current_token
ldw r16, 0(r16)
movi r17, STRING_TOKEN
bne r16, r17, tokenize_string_end #see if this is a string token
movia r16, ptr
ldw r17, 0(r16)
addi r4, r17, 1
movi r5, '"'
call strchar
beq r2, r0, tokenize_string_end #if strchar returned NULL
subi r2, r2, 1
sub r2, r2, r17 #r2 has the length of the string
movi r16, MAX_STRING_LENGTH
blt r2, r16, save_string_to_mem
mov r2, r16
save_string_to_mem:
movia r16, PRINT_STRING_BUF
movia r17, ptr
ldw r17, 0(r17)
addi r17, r17, 1
string_mem_copy:
bgt r2, r0, keep_copy
br tokenize_string_add_null
keep_copy:
ldb r4, 0(r17)
stb r4, 0(r16)
addi r16, r16, 1
addi r17, r17, 1
subi r2, r2, 1
br string_mem_copy
tokenize_string_add_null:
stb r0, 0(r16)
tokenize_string_end:
ldw r16, 0(sp)
ldw r17, 4(sp)
ldw ra, 8(sp)
addi sp, sp, 12
ret

#function: get the variable number of a character(when only allowing single character variable)
get_variable_num:
movia r2, ptr
ldw r2, 0(r2)
ldb r2, 0(r2)
subi r2, r2, 'a'
ret

#funtion: determine if tokenizer is finished by checking corrent token or the character to read
is_tokenize_finished:
subi sp, sp, 4
stw r16, 0(sp)
movia r2, ptr
ldw r2, 0(r2)
ldb r2, 0(r2)
beq r2, r0, token_is_finished
movia r16, current_token
ldw r16, 0(r16)
movi r2, EOF_TOKEN
beq r2, r16, token_is_finished
mov r2, r0
br is_tokenize_finished_end

token_is_finished:
movi r2, 1

is_tokenize_finished_end:
ldw r16, 0(sp)
addi sp, sp, 4
ret
.end