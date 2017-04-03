.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000

.global VGA_DISPLAY  
.text
VGA_DISPLAY:
  subi sp, sp, 44
  stw r16, 0(sp)
  stw r17, 4(sp)
  stw r18, 8(sp)
  stw r19, 12(sp)
  stw r4, 16(sp)
  stw r20, 20(sp)
  stw r6, 24(sp)
  stw r5, 28(sp)
  stw r3, 32(sp)
  stw r7, 36(sp)
  stw ra, 40(sp)
  ##only store callee save 
  
  
  movia r19,ADDR_VGA
  movia r3, ADDR_CHAR
  
  mov r6, r3 #r6 points to the blinking position, initiaily (0,0)
  
  mov r16, r0 #r16 = x //the position of a pixel is (x,y)
  mov r17, r0 #r17 = y
  movia r4, INPUT_BUF_PTR
  ldw r4, 0(r4) #r4 get the first address in INPUT_BUF_PTR
  
VGA_Loop:
  ldb r20, 0(r4)
  beq r0, r20, Done_Display #no ASCII to display in the memory
                            #or r4 points to the null character in the INPUT_BUF
  movi r5, 0x0D	#check if ENTER key			
  beq r20, r5, ENTER 
 
  call Write_Char

  addi r16, r16, 0b1 # x++
  movi r18, 0x050 #r18 = 80
  beq r16, r18, Move_to_Nextline #if x=80, move to next line
  br VGA_Loop
  

Move_to_Nextline:
  addi r17, r17, 0b1 # y++
  mov r16, r0 # x = 0
  ret
  
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

ENTER:
  addi r17, r17, 0b1 # y++
  mov r16, r0 # x = 0
  addi r4, r4, 0b1 #r4 now points to next char in INPUT_BUF
  movi r7, 0x080 #r7 = 128
  mul r7, r7, r17 #r7 = 128*y
  add r7, r7, r16 #r7 = x + 128*y
  add r6, r3, r7 #r6 = 0x09000000 + x + 128*y //the address for location (x,y) 
  movia r7, CURSOR_POS
  stw r6, 0(r7) #store new curr blinking position to CURSOR_POS
  br VGA_Loop
  #should not print ENTER on VGA?
  ret

  
BKSP_TO_LAST_LINE:
  movi r16, 0x4F # x = 79
  subi r17, r17, 0b1 # y--
  ret


  
Done_Display:
  ldw r16, 0(sp)
  ldw r17, 4(sp)
  ldw r18, 8(sp)
  ldw r19, 12(sp)
  ldw r4, 16(sp)
  ldw r20, 20(sp)
  ldw r6, 24(sp)
  ldw r5, 28(sp)
  ldw r7, 36(sp)
  ldw ra, 40(sp)
  addi sp, sp, 44
  ret

.end