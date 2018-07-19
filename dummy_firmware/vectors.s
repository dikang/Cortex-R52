
.cpu cortex-r52
.thumb

.thumb_func
.global _start
_start:
stacktop: .word 0x20001000
.word reset
.word hang
.word hang
.word hang
.word hang
.word hang
.word hang
.word hang
.word hang
.word hang
.word hang
.word hang
.word hang
.word hang
.word hang

.word irq0
.word irq1
.word irq2
.word irq3
.word irq4
.word irq5
.word irq6
.word irq7
.word irq8
.word irq9
.word irq10
.word irq11
.word irq12
.word irq13
.word irq14
.word irq15
.word irq16
.word irq17
.word irq18
.word irq19

.thumb_func
reset:
    bl notmain
    b hang
    b hang

.thumb_func
hang:   b .
    b hang 

.thumb_func
irq0:    
    bl irq0
    b hang
    b hang

.thumb_func
irq1:    
    bl irq1
    b hang
    b hang

.thumb_func
irq2:    
    bl irq2
    b hang
    b hang

.thumb_func
irq3:    
    bl irq3
    b hang
    b hang

.thumb_func
irq4:    
    bl irq4
    b hang
    b hang

.thumb_func
irq5:    
    bl irq5
    b hang
    b hang

.thumb_func
irq6:    
    bl irq6
    b hang
    b hang

.thumb_func
irq7:    
    bl irq7
    b hang
    b hang

.thumb_func
irq8:    
    bl irq8
    b hang
    b hang

.thumb_func
irq9:    
    bl irq9
    b hang
    b hang

.thumb_func
irq10:   
    bl irq10
    b hang
    b hang

.thumb_func
irq11:   
    bl irq11
    b hang
    b hang

.thumb_func
irq12:   
    bl irq12
    b hang
    b hang

.thumb_func
irq13:   
    bl irq13
    b hang
    b hang

.thumb_func
irq14:   
    bl irq14
    b hang
    b hang

.thumb_func
irq15:   
    bl irq15
    b hang
    b hang

.thumb_func
irq16:   
    bl irq16
    b hang
    b hang

.thumb_func
irq17:   
    bl irq17
    b hang
    b hang

.thumb_func
irq18:   
    bl irq18
    b hang
    b hang

.thumb_func
irq19:   
    bl irq19
    b hang
    b hang


.thumb_func
.globl PUT32
PUT32:
    str r1,[r0]
    bx lr
