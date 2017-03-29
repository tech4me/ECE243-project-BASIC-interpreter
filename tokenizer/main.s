.data
.global PROGRAM_BUF
PROGRAM_BUF:
.string "\"abc123\""
.skip 65536

.text
.global _start
_start:
movia sp, 0x03FFFFFC
movia r4, PROGRAM_BUF
call strlen
end:
br end
.end