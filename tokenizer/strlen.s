.text
.global strlen
#function: calculate the length of a string
#parameter: r4: pointer to the string
strlen: 
mov r2, r4
for_loop:
ldb r3, 0(r2)
beq r3, r0, end_loop
addi r2, r2, 1
br for_loop
end_loop:
sub r2, r2, r4
ret