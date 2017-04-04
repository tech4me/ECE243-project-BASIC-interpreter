.data
.align 2
.global INPUT_BUF_PTR
INPUT_BUF_PTR:
.word INPUT_BUF
.global CURSOR_POS #address of blinking position
CURSOR_POS:
.word 0
.global BLINK_FLAG
BLINK_FLAG:
.word 0
.global CHAR_COUNT
CHAR_COUNT:
.word 0

.global INPUT_BUF
INPUT_BUF:
.string "10 FOR A = 0 TO 10\n20 NEXT A"
.skip 4800 #Space left for input buffer

.global OUTPUT_BUF_PTR
OUTPUT_BUF_PTR:
.word OUTPUT_BUF
OUTPUT_BUF:
.skip 4800

.global DEBUG_BUF_PTR
DEBUG_BUF_PTR:
.word DEBUG_BUF
DEBUG_BUF:
.skip 4800

.text
.global _start
_start:
movia sp, 0x03FFFFFC #Reset stack pointer
call Init
movia r4, INPUT_BUF
call run
end:
br end
.end