.data
.global PROGRAM_BUF
PROGRAM_BUF:
.string "10000 FOR A \"abc\" \n IF"
.skip 65536
TEST_BUF:
.string "abcfff"

.text
.global _start
_start:
movia sp, 0x03FFFFFC
call tokenize_next
call tokenize_next
call tokenize_next
call tokenize_next
call tokenize_next
call tokenize_next
call tokenize_next
call tokenize_next
call tokenize_next
end:
br end
.end
