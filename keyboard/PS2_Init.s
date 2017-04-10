.equ PS2_Controller, 0xFF200100
.text
.global PS2_Init
PS2_Init:
movia r8, PS2_Controller
movi r9, 1
stwio r9, 4(r8) #enable read interrupt enable
rdctl r9, ctl3
ori r9, r9, 0x80
wrctl ctl3, r9 #enable IRQ7
ret
.end