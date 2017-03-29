.text
.global isdigit
#function: test if a char is a digit
#parameter r4: char
#return true is a digit false if not
isdigit:
subi sp, sp, 4
stw r16, 0(sp)
movi r16, '0'
blt r4, r16, false
movi r16, '9'
bgt r4, r16, false
true:
movi r2, 1
br exit
false:
mov r2, r0
exit:
ldw r16, 0(sp)
addi sp, sp, 4
ret
.end
