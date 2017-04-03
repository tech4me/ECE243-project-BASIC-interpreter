.text
.global strncmp
#function: compare two strings for the given length
#parameter: r4: pointer to string 1
#parameter: r5: pointer to string 2
#parameter: r6: length for the comparsion
#return: r2: for the given length 0 if two equal string, < 0 if string 1 has a lower value, > 0 if string 2 has a lower value
strncmp:
beq r6, r0, end_loop
ldb r2, 0(r4)
beq r2, r0, end_loop
ldb r3, 0(r5)
bne r2, r3, end_loop
addi r4, r4, 1
addi r5, r5, 1
subi r6, r6, 1
br strncmp
end_loop:
beq r6, r0, ret_0
sub r2, r2, r3
ret
ret_0:
mov r2, r0
ret