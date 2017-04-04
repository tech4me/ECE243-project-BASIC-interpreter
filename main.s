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
.string "10 FOR A = 0 TO 10\n"
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
call get_next_token
movia r4, current_token
stw r2, 0(r4)
call line_statement
end:
br end
.end