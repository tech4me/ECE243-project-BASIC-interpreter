.equ PS2_Controller, 0xFF200100
.text
.global PS2_ISR
PS2_ISR:
subi sp, sp, 4
stw ra, 0(sp)
movia r8, PS2_Controller
WAIT_FOR_PS2:
ldwio r9, 0(r8)
movia r10, 0xFFFF0000
and r10, r10, r9 #get high 16 bits of 
srli r10, r10, 0x10
#beq r10, r0, WAIT_FOR_PS2 #check again
andi r9, r9, 0xFF #get data itself in r9
movi r10, 0xE1
beq r9, r10, E1_IGNORE #should ignore the rest
movi r10, 0xE0
beq r9, r10, E0_READ_MORE #should read more
movi r10, 0xF0
beq r9, r10, F0_IGNORE #should ignore the rest
#The rest can directly save
movia r10, INPUT_BUF_PTR 
ldw r10, 0(r10) #r10 gets the first address in INPUT_BUF_PTR
movia r11, CHAR_COUNT
ldw r12, 0(r11) #r12 gets the count 
add r10, r10, r12 #r10 points to the last char in INPUT_BUF

movia r14, MODE_FLAG
stw r0, 0(r14) #set MODE_FLAG to 0 (default mode)
 

movi r14, 0x05 #make code for F1 button
beq r9, r14, OUTPUT_BUF_MODE #check if F1 is pressed, if yes, VGA displays OUTPUT_BUF

movi r14, 0x04 #make code for F3 button
beq r9, r14, OUTPUT_BUF_MODE #check if F3 is pressed, if yes, VGA displays DEBUG_BUF

#if neither F2 nor F3 is pressed, VGA displays INPUT_BUF and store char in INPUT_BUF
movia r13, ASCII_LIST_PTR
ldw r13, 0(r13) #r13 gets the first address in ASCII_LIST
add r9, r9, r13 #r9 now has the address of the ascii of curr char
ldb r13, 0(r9) #r13 gets the ascci of curr char 

movi r9, 0x08 #check if BACKSPACE key 
beq r13, r9, BACKSPACE

stb r13, 0(r10) #store input in INPUT_BUF
##stb r9, 0(r10) #store input in INPUT_BUF 

stb r0, 1(r10) #store a NULL character right after the last stored char in INPUT_BUF 


addi r12, r12, 1
stw r12, 0(r11) #save the new count back

movia r4, INPUT_BUF_PTR
ldw r4, 0(r4) #r4 get the first address in INPUT_BUF_PTR

call VGA_DISPLAY

#movia r13, CURSOR_POS
#ldw r11, 0(r13)
#addi r11, r11, 1
#stw r11, 0(r13)
br END

CALL_VGA:
call VGA_DISPLAY #let VGA display all chars in INPUT_BUF once
br END


E1_IGNORE:
ldwio r9, 0(r8)
movia r10, 0xFFFF0000
and r10, r9, r10
srli r10, r10, 0x10
beq r10, r0, F0_IGNORE #ignore everything in FIFO
br END

E0_READ_MORE:
ldwio r9, 0(r8)
andi r9, r9, 0xFF #r9 gets only the data itself (bit 0-7)
movi r10, 0xF0
beq r9, r10, F0_IGNORE #should ignore the rest
######
#case should be added for arrow keys
######
br END

F0_IGNORE:
ldwio r9, 0(r8)
movia r10, 0xFFFF0000
and r10, r9, r10
srli r10, r10, 0x10
beq r10, r0, F0_IGNORE #ignore everything in FIFO

br END

BACKSPACE:
movia r11, CHAR_COUNT
ldw r12, 0(r11) #r12 gets the count 
subi r12, r12, 1 #count --
stw r12, 0(r11)
subi r10, r10, 1 #r10 now points to the second last char in INPUT_BUF, 
stb r0, 0(r10) #store a NULL character right after the second last char in INPUT_BUF
subi r10, r10, 1 #r10 now points to the char right before the NULL char in INPUT_BUF
movia r15, CURSOR_POS
ldw r14, 0(r15) #r14 now gets the address of curr blinking position
movi r10, 32 #char: space 
stbio r10, 0(r14) #store a space char at curr blinking position
subi r14, r14, 1 #move the curr blinking position backwards: address --
stw r14, 0(r15)
br CALL_VGA


OUTPUT_BUF_MODE: #let VGA display content in OUTPUT_BUF when F1 is pressed
movia r4, OUTPUT_BUF

movi r14, 0x01
movia r15, MODE_FLAG 
stw r14, 0(r15) # set MODE_FLAG == 1

br CALL_VGA 


DEBUG_BUF_MODE: #let VGA display content in DEBUG_BUF when F3 is pressed
movia r4, DEBUG_BUF

movi r14, 0x03
movia r15, MODE_FLAG 
stw r14, 0(r15) # set MODE_FLAG == 3

br CALL_VGA


END:
ldw ra, 0(sp)
addi sp, sp, 4
ret
.end