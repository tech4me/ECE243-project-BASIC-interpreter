.text
.global atoi
#function: convert char to integer until the first non-number character
#parameter: r4 pointer to character string
atoi:
subi sp, sp, 16
stw r16, 0(sp)
stw r17, 4(sp)
stw r18, 8(sp)
stw ra, 12(sp)
mov r16, r4
mov r17, r0
next_char:
ldb r4, 0(r16)
mov r18, r4
call isdigit #test if the current char is a number or not
beq r2, r0, exit
muli r17, r17, 10 #current value multiply by 10
subi r18, r18, '0'
add r17, r17, r18
addi r16, r16, 1
br next_char
exit:
mov r2, r17
ldw r16, 0(sp)
ldw r17, 4(sp)
ldw r18, 8(sp)
ldw ra, 12(sp)
addi sp, sp, 16
ret