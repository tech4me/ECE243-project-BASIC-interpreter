.equ TIMER, 0xff202000
.equ TimerPeriod, 50000000

.global Timer_Init  
.text
Timer_Init:
movia r8, TIMER
movi r9, %hi(TimerPeriod)
stwio r9, 12(r8)  #set upper 16 bits of Timeout period
movi r9, %lo(TimerPeriod)
stwio r9, 8(r8) #set lower 16 bits of Timeout period
stwio r0,0(r8) #reset the timer
movi r9, 0b111 #start timer, continuous, interrupt enabled
stwio r9, 4(r8)

rdctl r9, ctl3
ori r9, r9, 1
wrctl ctl3, r9 #enable IRQ 0 for timer
ret

  
