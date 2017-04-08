.data
VARIABLE_ARRAY:
.skip 4*26

.text
.global get_variable
#function: get the variable from the variable array
#parameter: r4: the number corresponding to the variable
#return: r2: the value saved in the variable
get_variable:
movia r2, VARIABLE_ARRAY
add r4, r2, r4
ldw r2, 0(r4)
ret

.global set_variable
#function: set the variable in variable array to r5
#parameter: r4: the number corresponding to the variable
#parameter: r5: what you want to set the variable to
set_variable:
movia r2, VARIABLE_ARRAY
add r4, r2, r4
stw r5, 0(r4)
ret

.global variable_factor
#function: get the value of the variable from the variable array
variable_factor:
call get_variable_num
subi sp, sp, 4
stw r2, 0(sp)
movi r4, VARIABLE_TOKEN
call accept_token
ldw r2, 0(sp)
addi sp, sp, 4
ret