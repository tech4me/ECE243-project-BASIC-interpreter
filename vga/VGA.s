.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000

.global VGA_DISPLAY  
.text
VGA_DISPLAY:
  subi sp, sp, 24
  stw r16, 0(sp)
  stw r17, 4(sp)
  stw r18, 8(sp)
  stw r19, 12(sp)
  stw r20, 16(sp)
  stw ra, 20(sp)
  ##only store callee save 
  
  movia r19, ADDR_VGA
  movia r3, ADDR_CHAR
  
  mov r6, r3 #r6 points to the blinking position, initiaily (0,0)
  
  mov r16, r0 #r16 = x //the position of a pixel is (x,y)
  mov r17, r0 #r17 = y
  
  br CLEAR_SCREEN
  /*
  #check MODE to see if need to clear screen
  movia r20, MODE_FLAG
  ldw r20, 0(r20)
  movi r5, 0x01 
  beq r5, r20, CLEAR_SCREEN #if OUTPUT_MODE, clear screen first before printing any text
  movi r5, 0x02
  beq r5, r20, CLEAR_SCREEN #if DEBUG_MODE, clear screen first before printing any text
  */

#otherwise, INPUT_MODE, start printing directly  
VGA_Loop:
  ldb r20, 0(r4)
  beq r0, r20, Done_Display #no ASCII to display in the memory
                            #or r4 points to the null character in the INPUT_BUF
  
  #in INPUT_MODE print CR as a special character/ in OUTPUT_MODE and DEBUG_MODE print it as LF
  movia r5, MODE_FLAG
  ldw r5, 0(r5)
  beq r5, r0, check_lf
  #check both CR and LF
  movi r5, 0x0D	#check if CR key
  beq r20, r5, LF
  check_lf:
  movi r5, 0x0A	#check if LF key			
  beq r20, r5, LF
  
  movi r18, 0x050 #r18 = 80
  beq r16, r18, Move_to_Nextline #if x = 80, move to next line
 
  call Write_Char

  addi r16, r16, 0b1 # x++
 
  br VGA_Loop
  
Move_to_Nextline:

  ldb r5,0(r4) #r5 now has the curr char in the INPUT_BUF
  
  addi r17, r17, 0b1 # y++
  mov r16, r0 # x = 0
  
  movi r7, 0x080 #r7 = 128
  mul r7, r7, r17 #r7 = 128*y
  add r7, r7, r16 #r7 = x + 128*y
  add r6, r3, r7 #r6 = 0x09000000 + x + 128*y //the address for location (x,y) 
  
  stbio r5, 0(r6)#store curr char at location (x,y)
  addi r4, r4, 0b1 #r4 now points to next char in INPUT_BUF

  addi r6, r6, 1 #r6 now points to curr blinking position
  movia r7, CURSOR_POS
  stw r6, 0(r7) #store new curr blinking position to CURSOR_POS
  
  addi r16, r16, 0b1 # x++
  br VGA_Loop
  
  
Write_Char:

  ldb r5,0(r4) #r5 now has the curr char in the INPUT_BUF

  movi r7, 0x080 #r7 = 128
  mul r7, r7, r17 #r7 = 128*y
  add r7, r7, r16 #r7 = x + 128*y
  add r6, r3, r7 #r6 = 0x09000000 + x + 128*y //the address for location (x,y) 
  
  stbio r5, 0(r6)#store curr char at location (x,y)
  addi r4, r4, 0b1 #r4 now points to next char in INPUT_BUF
  
  addi r6, r6, 1 #r6 now points to curr blinking position
  movia r7, CURSOR_POS
  stw r6, 0(r7) #store new curr blinking position to CURSOR_POS
  
  ret 

LF:
  addi r17, r17, 0b1 # y++
  mov r16, r0 # x = 0
  addi r4, r4, 0b1 #r4 now points to next char in INPUT_BUF
  movi r7, 0x080 #r7 = 128
  mul r7, r7, r17 #r7 = 128*y
  add r7, r7, r16 #r7 = x + 128*y
  add r6, r3, r7 #r6 = 0x09000000 + x + 128*y //the address for location (x,y) 
  movia r7, CURSOR_POS
  ldw r20, 0(r7) #r20 now gets the curr blinking position
  movi r5, 32 #char: space 
  stbio r5, 0(r20) #store a space char at curr blinking position
  stw r6, 0(r7) #store new curr blinking position to CURSOR_POS
  br VGA_Loop
  #should not print ENTER on VGA?
  #ret
  
CLEAR_SCREEN:
  movi r7, 0x050 #80
  beq r16, r7, CLEAR_NEXT_LINE #if x==80, clear next line
  movi r5, 32 #char: space 
  movi r7, 0x080 #r7 = 128
  mul r7, r7, r17 #r7 = 128*y
  add r7, r7, r16 #r7 = x + 128*y
  add r6, r3, r7 #r6 = 0x09000000 + x + 128*y //the address for location (x,y) 
  stbio r5, 0(r6)#store SPACE at location (x,y)
  addi r16, r16, 1 #x++
  br CLEAR_SCREEN
  
CLEAR_NEXT_LINE:
  mov r16, r0 #x == 0
  addi r17, r17, 0x01 #y++
  
  movi r7, 0x03c #60
  beq r7, r17, DONE_CLEAR
  
  movi r5, 32 #char: space 
  movi r7, 0x080 #r7 = 128
  mul r7, r7, r17 #r7 = 128*y
  add r7, r7, r16 #r7 = x + 128*y
  add r6, r3, r7 #r6 = 0x09000000 + x + 128*y //the address for location (x,y) 
  stbio r5, 0(r6)#store SPACE at location (x,y)
  addi r16, r16, 1 #x++
  br CLEAR_SCREEN
  
DONE_CLEAR:
  mov r16, r0
  mov r17, r0
  br VGA_Loop
  
Done_Display:
  ldw r16, 0(sp)
  ldw r17, 4(sp)
  ldw r18, 8(sp)
  ldw r19, 12(sp)
  ldw r20, 16(sp)
  ldw ra, 20(sp)
  addi sp, sp, 24
  ret