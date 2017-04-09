.include "defines.h"
.data
.align 2
VARIABLE_ARRAY:
.skip 4*26

.text
.global get_variable
#function: get the variable from the variable array
#parameter: r4: the number corresponding to the variable
#return: r2: the value saved in the variable
get_variable:
movia r2, VARIABLE_ARRAY
slli r4, r4, 2
add r4, r2, r4
ldw r2, 0(r4)
ret

.global set_variable
#function: set the variable in variable array to r5
#parameter: r4: the number corresponding to the variable
#parameter: r5: what you want to set the variable to
set_variable:
movia r2, VARIABLE_ARRAY
slli r4, r4, 2
add r4, r2, r4
stw r5, 0(r4)
ret

.global variable_factor
#function: get the value of the variable from the variable array
variable_factor:
subi sp, sp, 4
stw ra, 0(sp)
call get_variable_num
mov r4, r2
call get_variable
subi sp, sp, 4
stw r2, 0(sp)
movi r4, VARIABLE_TOKEN
call accept_token
ldw r2, 0(sp)
addi sp, sp, 4
ldw ra, 0(sp)
addi sp, sp, 4
ret