.include "defines.h"
.data
STR_LET:
.string "LET"

STR_PRINT:
.string "PRINT"

STR_IF:
.string "IF"

STR_THEN:
.string "THEN"

STR_ELSE:
.string "ELSE"

STR_FOR:
.string "FOR"

STR_TO:
.string "TO"

STR_NEXT:
.string "NEXT"

STR_GOTO:
.string "GOTO"

STR_GOSUB:
.string "GOSUB"

STR_RETURN:
.string "RETURN"

STR_REM:
.string "REM"

STR_PEEK:
.string "PEEK"

STR_POKE:
.string "POKE"

STR_END:
.string "END"

STR_ERROR:
.string ""

.data
.align 2
.global KEYWORD_TOKEN
KEYWORD_TOKEN:

.global KEYWORD_LET
KEYWORD_LET:
.word STR_LET
.word LET_TOKEN

.global KEYWORD_PRINT
KEYWORD_PRINT:
.word STR_PRINT
.word PRINT_TOKEN

.global KEYWORD_IF
KEYWORD_IF:
.word STR_IF
.word IF_TOKEN

.global KEYWORD_THEN
KEYWORD_THEN:
.word STR_THEN
.word THEN_TOKEN

.global KEYWORD_ELSE
KEYWORD_ELSE:
.word STR_ELSE
.word ELSE_TOKEN

.global KEYWORD_FOR
KEYWORD_FOR:
.word STR_FOR
.word FOR_TOKEN

.global KEYWORD_TO
KEYWORD_TO:
.word STR_TO
.word TO_TOKEN

.global KEYWORD_NEXT
KEYWORD_NEXT:
.word STR_NEXT
.word NEXT_TOKEN

.global KEYWORD_GOTO
KEYWORD_GOTO:
.word STR_GOTO
.word GOTO_TOKEN

.global KEYWORD_GOSUB
KEYWORD_GOSUB:
.word STR_GOSUB
.word GOSUB_TOKEN

.global KEYWORD_RETURN
KEYWORD_RETURN:
.word STR_RETURN
.word RETURN_TOKEN

.global KEYWORD_REM
KEYWORD_REM:
.word STR_REM
.word REM_TOKEN

.global KEYWORD_PEEK
KEYWORD_PEEK:
.word STR_PEEK
.word PEEK_TOKEN

.global KEYWORD_POKE
KEYWORD_POKE:
.word STR_POKE
.word POKE_TOKEN

.global KEYWORD_END
KEYWORD_END:
.word STR_END
.word END_TOKEN

.global KEYWORD_ERROR
KEYWORD_ERROR:
.word STR_ERROR
.word ERROR_TOKEN

.global ptr
ptr:
.word INPUT_BUF

.global next_ptr
next_ptr:
.word INPUT_BUF

.global current_token
current_token:
.word ERROR_TOKEN