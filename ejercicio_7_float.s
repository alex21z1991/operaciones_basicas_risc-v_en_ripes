.data
A: .float 10.0,9.0,8.0,7.0,6.0,5.0,4.0,3.0,2.0,1.0   # arreglo A (valores descendentes)
B: .float 1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,0.0    # arreglo B (?ltimo valor es 0.0)

.text
.globl main

main:
    li x1,0          # i = 0 (contador del ciclo)
    li x2,10         # N = 10 (cantidad de elementos a recorrer)

    la x3,A          # x3 guarda direcci?n inicial de A (puntero a A[0])
    la x4,B          # x4 guarda direcci?n inicial de B (puntero a B[0])

while:
    bge x1,x2,salto  # si i >= N, salir del ciclo (fin del while)

    flw f2,0(x4)     # cargar B[i] en registro flotante f2

    feq.s x5,f2,f0   # comparar B[i] con 0.0 ? x5 = 1 si es igual, si no 0

    bne x5,x0,salto2 # si B[i] == 0.0, saltar la resta

    flw f1,0(x3)     # cargar A[i] en f1 (solo si B[i] != 0)
    fsub.s f2,f2,f1  # B[i] = B[i] - A[i]
    fsw f2,0(x4)     # guardar resultado en B[i]

salto2:
    addi x3,x3,4     # avanzar puntero de A al siguiente float (A[i+1])
    addi x4,x4,4     # avanzar puntero de B al siguiente float (B[i+1])
    addi x1,x1,1     # i = i + 1

    j while          # volver al inicio del ciclo

salto:
    ecall            # terminar programa