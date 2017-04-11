.data
.align 2
.global INPUT_BUF_PTR
INPUT_BUF_PTR:
.word INPUT_BUF_END - 1
.global INPUT_BUF
INPUT_BUF:
.ascii "10 PEEK SW_ADDR, A\n"
.ascii "20 POKE LED_ADDR, A\n"
/*
.ascii "10 LET A = 1\n"
.ascii "20 FOR I = 0 TO 9\n"
.ascii "25 LET B = 0\n"
.ascii "30 FOR J = 0 TO I + 1\n"
.ascii "40 LET D = (A - J)\n"
.ascii "50 LET K = J\n"
.ascii "60 IF K = 0 THEN GOTO 95 ELSE GOTO 70\n" 
.ascii "70 LET D = (D * 10)\n"
.ascii "80 LET K = (K - 1)\n"
.ascii "90 GOTO 60\n"
.ascii "95 LET B = (B + D)\n"
.ascii "100 NEXT J\n"
.ascii "110 LET C = ((B * 8) + A)\n"
.ascii "120 PRINT C; \"\" \n"
.ascii "130 PRINT \" = \" \n"
.ascii "140 PRINT B; \"\" \n"
.ascii "150 PRINT \" * 8 + \" \n"
.ascii "160 PRINT A; \"\r\"\n"
.ascii "170 LET A = (A + 1)\n"
.ascii "180 NEXT I\n"
.ascii "190 END\n"
*/
#.ascii "10 LET A = (2*(50))\n"
#.ascii "20 PRINT A;\"\r\"\n"
#.ascii "30 LET B = 90\n"
#.ascii "40 PRINT A * B;\"\r\"\n"
#.ascii "50 IF A < 0 THEN LET A = 100 ELSE LET A = -100\n"
#.ascii "60 PRINT A;\"\r\"\n"
#.ascii "70 GOTO 90\n"
#.ascii "75 PRINT \"hahaha\r\"\n"
#.ascii "80 RETURN\n"
#.ascii "90 PRINT B + 90; \"\r\"\n"
#.ascii "100 FOR I = 0 TO 10\n"
#.ascii "110 PRINT A;\"\r\"\n"
#.ascii "120 NEXT I\n"
#.ascii "130 GOSUB 75\n"
#.ascii "140 END\n"
.byte 0
INPUT_BUF_END:
.skip 4800 #Space left for input buffer

.align 2
.global CURSOR_POS #address of blinking position
CURSOR_POS:
.word 0
.global BLINK_FLAG
BLINK_FLAG:
.word 0

.global MODE_FLAG #0 for INPUT_BUF_MODE; 1 for OUTPUT_BUF_MODE; 2 for DEBUG_BUF_MODE
MODE_FLAG:
.word 0

.align 2
.global OUTPUT_BUF_PTR
OUTPUT_BUF_PTR:
.word OUTPUT_BUF
.global OUTPUT_BUF
OUTPUT_BUF:
.byte 0
.skip 4800

.align 2
.global DEBUG_BUF_PTR
DEBUG_BUF_PTR:
.word DEBUG_BUF
.global DEBUG_BUF
DEBUG_BUF:
.byte 0
.skip 4800

.text
.align 2
.global _start
_start:
movia sp, 0x03FFFFFC #Reset stack pointer
call Init

movia r4, INPUT_BUF
call VGA_DISPLAY

main_end:
br main_end

.global main_reenable_it
main_reenable_it:
#re-enable interrupt
movi r2, 1
wrctl ctl0, r2
br main_end
.end