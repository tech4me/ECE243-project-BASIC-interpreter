#interpreter defines
.equ MAX_LINE_NUM, 60
.equ MAX_STRING_LENGTH, 40
.equ MAX_NUMBER_LENGTH, 6

#token defines
.equ ERROR_TOKEN, 0
.equ EOF_TOKEN, 1
.equ NUM_TOKEN, 2
.equ STRING_TOKEN, 3
.equ VARIABLE_TOKEN, 4

.equ COMMA_TOKEN, 5
.equ SEMICOLON_TOKEN, 6
.equ PLUS_TOKEN, 7
.equ MINUS_TOKEN, 8
.equ AND_TOKEN, 9
.equ OR_TOKEN, 10
.equ ASTR_TOKEN, 11
.equ SLASH_TOKEN, 12
.equ MOD_TOKEN, 13
.equ HASH_TOKEN, 14
.equ LEFTPAREN_TOKEN, 15
.equ RIGHTPAREN_TOKEN, 16
.equ LT_TOKEN, 17
.equ GT_TOKEN, 18
.equ EQ_TOKEN, 19
.equ CR_TOKEN, 20

.equ LET_TOKEN, 21
.equ PRINT_TOKEN, 22
.equ IF_TOKEN, 23
.equ THEN_TOKEN, 24
.equ ELSE_TOKEN, 25
.equ FOR_TOKEN, 26
.equ TO_TOKEN, 27
.equ NEXT_TOKEN, 28
.equ GOTO_TOKEN, 29
.equ GOSUB_TOKEN, 30
.equ RETURN_TOKEN, 31
.equ CALL_TOKEN, 32
.equ REM_TOKEN, 33
.equ PEEK_TOKEN, 34
.equ POKE_TOKEN, 35
.equ END_TOKEN, 36