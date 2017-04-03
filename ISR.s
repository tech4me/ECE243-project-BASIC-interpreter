.section .exceptions, "ax"
.global ISR
ISR:
#save all register
subi sp, sp, 108
stw r2, 0(sp)
stw r3, 4(sp)
stw r4, 8(sp)
stw r5, 12(sp)
stw r6, 16(sp)
stw r7, 20(sp)
stw r8, 24(sp)
stw r9, 28(sp)
stw r10, 32(sp)
stw r11, 36(sp)
stw r12, 40(sp)
stw r13, 44(sp)
stw r14, 48(sp)
stw r15, 52(sp)
stw r16, 56(sp)
stw r17, 60(sp)
stw r18, 64(sp)
stw r19, 68(sp)
stw r20, 72(sp)
stw r21, 76(sp)
stw r22, 80(sp)
stw r23, 84(sp)
stw r24, 88(sp)

stw r26, 92(sp)

stw r28, 96(sp)
stw r29, 100(sp)

stw r31, 104(sp)

#see if PS2 caused IRQ
rdctl et, ctl4
andi et, et, 0x80 #IRQ7
bne et, r0, IRQ7

#see if TIMER caused IRQ
rdctl et, ctl4
andi et, et, 1 #IRQ0
bne et, r0, IRQ0
br iEND

IRQ7:
call PS2_ISR
br iEND

IRQ0:
call Timer_ISR

iEND:
#restore all register
ldw r2, 0(sp)
ldw r3, 4(sp)
ldw r4, 8(sp)
ldw r5, 12(sp)
ldw r6, 16(sp)
ldw r7, 20(sp)
ldw r8, 24(sp)
ldw r9, 28(sp)
ldw r10, 32(sp)
ldw r11, 36(sp)
ldw r12, 40(sp)
ldw r13, 44(sp)
ldw r14, 48(sp)
ldw r15, 52(sp)
ldw r16, 56(sp)
ldw r17, 60(sp)
ldw r18, 64(sp)
ldw r19, 68(sp)
ldw r20, 72(sp)
ldw r21, 76(sp)
ldw r22, 80(sp)
ldw r23, 84(sp)
ldw r24, 88(sp)

ldw r26, 92(sp)

ldw r28, 96(sp)
ldw r29, 100(sp)

ldw r31, 104(sp)
addi sp, sp, 108
subi ea, ea, 4
eret

.end