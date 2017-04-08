.text
.global print_to_debug
#function: print to the debug screen
#parameter: r4: pointer to input character string
print_to_debug:
subi sp, sp, 12
stw ra, 0(sp)
stw r16, 4(sp)
stw r17, 8(sp)

movia r16, DEBUG_BUF_PTR
ldw r17, 0(r16)

call strlen

string_mem_copy:
bgt r2, r0, keep_copy
br string_add_null
keep_copy:
ldb r11, 0(r4)
stb r11, 0(r17)
addi r17, r17, 1
addi r4, r4, 1
subi r2, r2, 1
br string_mem_copy
string_add_null:
stw r17, 0(r16)
stb r0, 0(r17)

###
#only print all when selecting the corresponding buffer
#movia r4, DEBUG_BUF
#call VGA_DISPLAY

ldw ra, 0(sp)
ldw r16, 4(sp)
ldw r17, 8(sp)
addi sp, sp, 12
ret