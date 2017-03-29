.include "tokens.h"

.text
.global singlechar
#function: determine what kind of char token is ptr pointering to
singlechar:
subi sp, sp, 8
stw r16, 0(sp)
stw r17, 4(sp)

movia r16, ptr
stb r16, 0(r16)
movi r17, '\n'
beq r16, r17, RET_CR
movi r17, ','
beq r16, r17, RET_COMMA
movi r17, ';'
beq r16, r17, RET_SEMICOLON
movi r17, '+'
beq r16, r17, RET_PLUS
movi r17, '-'
beq r16, r17, RET_MINUS
movi r17, '&'
beq r16, r17, RET_AND
movi r17, '|'
beq r16, r17, RET_OR
movi r17, '*'
beq r16, r17, RET_ASTR
movi r17, '/'
beq r16, r17, RET_SLASH
movi r17, '%'
beq r16, r17, RET_MOD
movi r17, '#'
beq r16, r17, RET_HASH
movi r17, '('
beq r16, r17, RET_LEFTPAREN
movi r17, ')'
beq r16, r17, RET_RIGHTPAREN
movi r17, '<'
beq r16, r17, RET_LT
movi r17, '>'
beq r16, r17, RET_GT
movi r17, '='
beq r16, r17, RET_EQ
br RET_0

RET_CR:
movi r2, CR_TOKEN
br end

RET_COMMA:
movi r2, COMMA_TOKEN
br end

RET_SEMICOLON:
movi r2, SEMICOLON_TOKEN
br end

RET_PLUS:
movi r2, PLUS_TOKEN
br end

RET_MINUS:
movi r2, MINUS_TOKEN
br end

RET_AND:
movi r2, AND_TOKEN
br end

RET_OR:
movi r2, OR_TOKEN
br end

RET_ASTR:
movi r2, ASTR_TOKEN
br end

RET_SLASH:
movi r2, SLASH_TOKEN
br end

RET_MOD:
movi r2, MOD_TOKEN
br end

RET_HASH:
movi r2, HASH_TOKEN
br end

RET_LEFTPAREN:
movi r2, LEFTPAREN_TOKEN
br end

RET_RIGHTPAREN:
movi r2, RIGHTPAREN_TOKEN
br end

RET_LT:
movi r2, LT_TOKEN
br end

RET_GT:
movi r2, GT_TOKEN
br end

RET_EQ:
movi r2, EQ_TOKEN
br end

RET_0:
mov r2, r0
br end

end:
ldw r16, 0(sp)
ldw r17, 4(sp)
addi sp, sp, 8
ret
.end