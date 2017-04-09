.text
.global itoa
#function: implementation of the c function itoa that covert a integer into a string this function support base 2, base 10, and base 16
#parameter: r4: integer to print
#parameter: r5: char * to put the result in
#parameter: r6: base number
itoa:
subi sp, sp, 16
stw r16, 0(sp)
stw r17, 4(sp)
stw r18, 8(sp)
stw ra, 12(sp)

beq r4, r0, print_zero

#negetive number are only handled in base10 otherwise unsigned
blt r4, r0, input_lt_zero
br do_prefix
input_lt_zero:
movi r16, 10
beq r6, r16, handle_base_10_neg
br do_prefix

handle_base_10_neg:
sub r4, r0, r4 #r4 = -r4
#add negetive sign
movi r2, '-'
stb r2, 0(r5)
addi r5, r5, 1

do_prefix:

movi r16, 2
beq r6, r16, add_base_2_prefix
movi r16, 16
beq r6, r16, add_base_16_prefix
br finish_prefix

add_base_2_prefix:
call base_2_prefix
br finish_prefix

add_base_16_prefix:
call base_16_prefix

finish_prefix:
mov r17, r5 #saves the position to start reversing

process_digit:
beq r4, r0, process_digit_end
subi sp, sp, 8
stw r4, 0(sp)
stw r5, 4(sp)
mov r5, r6
call mod # r2 = r4 % r6
ldw r4, 0(sp)
ldw r5, 4(sp)
addi sp, sp, 8

divu r4, r4, r6 # r4 = r4 / r6
movi r3, 10
blt r2, r3, number_range
br alphabet_range

number_range:
addi r2, r2, '0'
stb r2, 0(r5)
addi r5, r5, 1
br process_digit
alphabet_range:
addi r2, r2, 'A'
subi r2, r2, 10
stb r2, 0(r5)
addi r5, r5, 1
br process_digit
process_digit_end:

stb r0, 0(r5) #put the null terminal character
#reverse the string
subi r5, r5, 1

reverse_loop:
bge r17, r5, finish_reverse
ldb r18, 0(r17)
ldb r16, 0(r5)
stb r18, 0(r5)
stb r16, 0(r17)
addi r17, r17, 1
subi r5, r5, 1
br reverse_loop

finish_reverse:

itoa_end:
ldw r16, 0(sp)
ldw r17, 4(sp)
ldw r18, 8(sp)
ldw ra, 12(sp)
addi sp, sp, 16
ret

print_zero:
movi r2, 2
beq r6, r2, add_base_2_prefix_zero
movi r2, 16
beq r6, r2, add_base_16_prefix_zero
#base 10 no prefix
br zero_print

add_base_2_prefix_zero:
call base_2_prefix
br zero_print

add_base_16_prefix_zero:
call base_16_prefix

zero_print:
movi r2, '0'
stb r2, 0(r5)
addi r5, r5, 1
stb r0, 0(r5)
br itoa_end

base_2_prefix:
movi r2, '0'
stb r2, 0(r5)
addi r5, r5, 1
movi r2, 'b'
stb r2, 0(r5)
addi r5, r5, 1
ret

base_16_prefix:
movi r2, '0'
stb r2, 0(r5)
addi r5, r5, 1
movi r2, 'x'
stb r2, 0(r5)
addi r5, r5, 1
ret

#function: helper to do mode operation r2 = r4 % r5
mod:
divu r2, r4, r5
mul r2, r2, r5
sub r2, r4, r2
ret