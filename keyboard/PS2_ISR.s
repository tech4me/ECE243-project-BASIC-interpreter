.equ PS2_Controller, 0xFF200100

.data
.align 2
F0_State:
.word 0
Shift_Pressed:
.word 0

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
#movi r10, 0xE1
#beq r9, r10, E1_IGNORE #should ignore the rest
#movi r10, 0xE0
#beq r9, r10, E0_READ_MORE #should read more

movia r14, F0_State
ldw r14, 0(r14)
bne r14, r0, F0_HANDLE_SECOND

movi r10, 0xF0
beq r9, r10, F0_HANDLE_FIRST
#The rest can directly save
movia r10, INPUT_BUF_PTR 
ldw r10, 0(r10)

movi r14, 0x05 #make code for F1 button
beq r9, r14, INPUT_BUF_MODE #check if F1 is pressed, if yes, VGA displays INPUT_BUF

movi r14, 0x06 #make code for F2 button
beq r9, r14, OUTPUT_BUF_MODE #check if F2 is pressed, if yes, VGA displays OUTPUT_BUF

movi r14, 0x04 #make code for F3 button
beq r9, r14, DEBUG_BUF_MODE #check if F3 is pressed, if yes, VGA displays DEBUG_BUF

movi r14, 0x03 #make code for F5 button
beq r9, r14, RUN_MODE #check if F5 is pressed, if yes, run interpreter, and VGA displays OUTPUT_BUF

movia r14, MODE_FLAG 
ldw r14, 0(r14)
bne r14, r0, END #not in input mode, abondon all input other then F keys

movi r14, Shift_Pressed 
ldw r14, 0(r14)
bne r14, r0, SHIFT_VERSION

movi r14, 0x12 
beq r9, r14, SHIFT_PRESSED #shift pressed, set bool to true

#if F is not pressed, VGA displays INPUT_BUF and store char in INPUT_BUF
movia r13, ASCII_LIST
add r9, r9, r13 #r9 now has the address of the ascii of curr char
ldb r13, 0(r9) #r13 gets the ascci of curr char 

movi r9, 0x08 #check if BACKSPACE key 
beq r13, r9, BACKSPACE

SHIFT_VERSION_SKIP:

beq r13, r0, END #don't do anything if that character is not implemented

stb r13, 0(r10) #store input in INPUT_BUF

stb r0, 1(r10) #store a NULL character right after the last stored char in INPUT_BUF 


addi r10, r10, 1

movia r4, INPUT_BUF_PTR
stw r10, 0(r4) #store the new pointer pos

movia r4, INPUT_BUF
call VGA_DISPLAY
br END

/*
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
*/

F0_HANDLE_FIRST:
movia r14, F0_State
movi r13, 1
stw r13, 0(r14)
#ldwio r9, 0(r8)
#movia r10, 0xFFFF0000
#and r10, r9, r10
#srli r10, r10, 0x10
#beq r10, r0, F0_HANDLE #ignore everything in FIFO
br END

F0_HANDLE_SECOND:
movia r14, F0_State
stw r0, 0(r14)
movi r14, 0x12
beq r9, r14, SHIFT_RELEASED #see if shift is released
br END

BACKSPACE:
subi r10, r10, 1 #r10 now points to the second last char in INPUT_BUF
movia r11, INPUT_BUF
blt r10, r11, start_of_screen
stb r0, 0(r10) #store a NULL character right after the second last char in INPUT_BUF
movia r11, INPUT_BUF_PTR
stw r10, 0(r11)
movia r15, CURSOR_POS
ldw r14, 0(r15) #r14 now gets the address of curr blinking position
movi r10, 32 #char: space 
stbio r10, 0(r14) #store a space char at curr blinking position
subi r14, r14, 1 #move the curr blinking position backwards: address --
stw r14, 0(r15)
start_of_screen:
movia r4, INPUT_BUF
call VGA_DISPLAY
br END

INPUT_BUF_MODE: #let VGA display content in OUTPUT_BUF when F1 is pressed
movia r4, INPUT_BUF

movi r14, 0x00
movia r15, MODE_FLAG 
stw r14, 0(r15) # set MODE_FLAG == 0

call VGA_DISPLAY
br END

OUTPUT_BUF_MODE: #let VGA display content in OUTPUT_BUF when F2 is pressed
movia r4, OUTPUT_BUF

movi r14, 0x01
movia r15, MODE_FLAG 
stw r14, 0(r15) # set MODE_FLAG == 1

call VGA_DISPLAY
br END


DEBUG_BUF_MODE: #let VGA display content in DEBUG_BUF when F3 is pressed
movia r4, DEBUG_BUF

movi r14, 0x02
movia r15, MODE_FLAG 
stw r14, 0(r15) # set MODE_FLAG == 2

call VGA_DISPLAY
br END

RUN_MODE:
movi r14, 0x01
movia r15, MODE_FLAG 
stw r14, 0(r15) # set MODE_FLAG == 1

movia r4, INPUT_BUF
call run

movia r4, OUTPUT_BUF
call VGA_DISPLAY
br END

END:
ldw ra, 0(sp)
addi sp, sp, 4
ret

SHIFT_PRESSED:
movia r14, Shift_Pressed
movi r13, 1
stw r13, 0(r14)
br END

SHIFT_RELEASED:
movia r14, Shift_Pressed
stw r0, 0(r14)
br END

SHIFT_VERSION:
movia r13, ASCII_LIST
add r9, r9, r13 #r9 now has the address of the ascii of curr char
addi r9, r9, 256
ldb r13, 0(r9) #r13 gets the ascci of curr char 
br SHIFT_VERSION_SKIP