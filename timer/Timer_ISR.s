.equ TIMER, 0xff202000
.equ ADDR_VGA, 0x08000000
.equ ADDR_CHAR, 0x09000000
.text
.global Timer_ISR
Timer_ISR:

  movia r8, MODE_FLAG
  ldw r8, 0(r8) #r8 now gets the MODE_FLAG value
  movi r9, 0x01
  beq r9, r8, TIMER_END #if MODE_FLAG == 1 (OUTPUT_MODE), no blink 
  movi r9, 0x03
  beq r9, r8, TIMER_END #if MODE_FLAG == 3 (DEBUG_MODE), no blink 
  
  
  movia r8, TIMER
  stwio r0, 0(r8) #ack Timer interrupt by clearing timeout bit
  #movi r8, 1
  #wrctl ctl0, r8 #reenable interrupts by setting PIE bit to 1
  
  #blink
  #movia r8, CURSOR_POS
  #ldw r8, 0(r8)
  #ldbio  r9, 0(r8) #r9 now gets the blinking content 
  #beq r9, r0, First_Blink #check if first Timer interrupt
  #movi r10, 32 #char: space
  #beq r9, r10, Underline #check if CURSOR_POS is space, if yes, change to underline
  #movi r10, 95 #char: underline
  #beq r9, r10, Space #check if CURSOR_POS is underline, if yes, change to space
  
  #stbio r10, 0(r8) #print underline at CURSOR_POS
  
  
  #br TIMER_END

  
#First_Blink:
 # movi r10, 32 #char: space
  #stbio r10, 0(r8) #print space at CURSOR_POS
  #ret

#Underline:
 # movi r10, 95 #char: underline
  #stbio r10, 0(r8) #print underline at CURSOR_POS
  #ret

#Space:
 # movi r10, 32 #char: space
  #stbio r10, 0(r8)
  #ret
  
  
  movia r8, BLINK_FLAG
  ldw r9, 0(r8)
  movia r11, CURSOR_POS
  ldw r11, 0(r11) #r11 now has the blinking address 
  beq r9, r0, Underline #if BLINK_FLAG == 0, print underline
  movi r10, 32 #char: space
  stbio r10, 0(r11) #print space at CURSOR_POS
  stw r0, 0(r8) #set BLINK_FLAG == 0
  br TIMER_END
  
  
  
Underline:
  movi r10, 95 #char: underline
  stbio r10, 0(r11) #print underline at CURSOR_POS
  
  #stb r10, 0(r11) #print underline at CURSOR_POS
  
  addi r9, r9, 1 #set BLINK_FLAG to 1
  stw r9, 0(r8)
  br TIMER_END
  
TIMER_END:
  ret
.end