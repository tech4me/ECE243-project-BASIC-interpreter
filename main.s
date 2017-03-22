.data
.align 2
.global INPUT_BUF_PTR
INPUT_BUF_PTR:
.word INPUT_BUF
.global CHAR_COUNT
CHAR_COUNT:
.word 0
INPUT_BUF:
.skip 65536 #Space left for input buffer

.text
.global _start
_start:
movia sp, 0x03FFFFFC #Reset stack pointer
call Init
end:
br end
.end