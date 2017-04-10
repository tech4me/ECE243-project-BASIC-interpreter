.include "defines.h"
.text
.global statement
statement:
subi sp, sp, 12
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)

movia r16, current_token
ldw r16, 0(r16)
movi r17, LET_TOKEN
beq r16, r17, LET
movi r17, VARIABLE_TOKEN
beq r16, r17, VARIABLE
movi r17, PRINT_TOKEN
beq r16, r17, PRINT
movi r17, IF_TOKEN
beq r16, r17, IF
movi r17, FOR_TOKEN
beq r16, r17, FOR
movi r17, NEXT_TOKEN
beq r16, r17, NEXT
movi r17, GOTO_TOKEN
beq r16, r17, GOTO
movi r17, GOSUB_TOKEN
beq r16, r17, GOSUB
movi r17, RETURN_TOKEN
beq r16, r17, RETURN
movi r17, PEEK_TOKEN
beq r16, r17, PEEK
movi r17, POKE_TOKEN
beq r16, r17, POKE
movi r17, END_TOKEN
beq r16, r17, END
br DEFAULT

statement_end:
ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
addi sp, sp, 12
ret

LET:
movi r4, LET_TOKEN
call accept_token

VARIABLE:
call let_statement
br statement_end

PRINT:
call print_statement
br statement_end

IF:
call if_statement
br statement_end

FOR:
call for_statement
br statement_end

NEXT:
call next_statement
br statement_end

GOTO:
call goto_statement
br statement_end

GOSUB:
call gosub_statement
br statement_end

RETURN:
call return_statement
br statement_end

PEEK:
#call peek_statement
br statement_end

POKE:
#call poke_statement
br statement_end

END:
call end_statement
br statement_end

DEFAULT:
#call unrecognized_token
#########################
#########################
#########################
br statement_end