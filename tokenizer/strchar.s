.text
.global strchar
#function: find the first occurence of a char in a string
#parameter: r4: pointer to the string
#parameter: r5: character that you want to find
#return: r2: NULL if no char found, pointer to that char if found
strchar:
subi sp, sp, 8
stw r16, 0(sp)
stw r17, 4(sp)

mov r17, r0
add r17, r17, r4
next_char:
ldb r16, 0(r17)
bne r16, r5, not_right_char
#if found the right character
mov r2, r17
br strchar_end

not_right_char:
addi r17, r17, 1
ldb r16, 0(r17)
bne r16, r0, next_char
mov r2, r0 #return NULL if nothing if found

strchar_end:
ldw r16, 0(sp)
ldw r17, 4(sp)
addi sp, sp, 8
ret