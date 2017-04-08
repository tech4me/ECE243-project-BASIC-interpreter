.data
.align 2
.global INPUT_BUF_PTR
INPUT_BUF_PTR:
.word INPUT_BUF
.global INPUT_BUF
INPUT_BUF:
.string "10 PRINT \"ABC\", \"HAHA\""
.skip 4800 #Space left for input buffer

.align 2
.global CURSOR_POS #address of blinking position
CURSOR_POS:
.word 0
.global BLINK_FLAG
BLINK_FLAG:
.word 0

.global MODE_FLAG #0 for INPUT_BUF_MODE; 1 for OUTPUT_BUF_MODE; 3 for DEBUG_BUF_MODE
MODE_FLAG:
.word 0

.global CHAR_COUNT
CHAR_COUNT:
.word 0

.align 2
.global OUTPUT_BUF_PTR
OUTPUT_BUF_PTR:
.word OUTPUT_BUF
.global OUTPUT_BUF
OUTPUT_BUF:
.string "ABCD"
.skip 4800

.align 2
.global DEBUG_BUF_PTR
DEBUG_BUF_PTR:
.word DEBUG_BUF
.global DEBUG_BUF
DEBUG_BUF:
.skip 4800

.text
.align 2
.global _start
_start:
movia sp, 0x03FFFFFC #Reset stack pointer
call Init
movia r4, INPUT_BUF
call run
#call print_to_output
end:
br end
.end