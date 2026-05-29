# estudio risc-v 
.data
A :.float 1.0,2.0,3.0,4.0,5.0
B :.float 1.0,2.0,3.0,4.0,5.0
.globl main
.text 
main:
    li x1,0
    li x2,5
    la x3,A
    la x4,B
    li x6,3
loop:
    beq x1,x2,salto1
    flw f1,0(x3)
    flw f2,0(x4)
    addi x1,x1,1
    addi x3,x3,4
    addi x4,x4,4
    fmult.s f1,f1,f2
    
    beq x1,x6,salto2
    j loop 
salto2:
    fdiv.s f1,f2,f1
salto1:
    ecall