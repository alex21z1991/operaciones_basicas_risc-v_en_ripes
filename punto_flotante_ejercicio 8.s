.data
X: .float 0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0   # X = arreglo donde se guarda el resultado acumulado
Y: .float 10.0,9.0,8.0,7.0,6.0,5.0,4.0,3.0,2.0,1.0   # Y = arreglo de entrada
Z: .float 1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0    # Z = arreglo de 1's

.text
.globl main

main:
    li x1, 0          # i = 0 (contador del ciclo)
    li x2, 10         # N = 10 (cantidad de elementos)

    fmv.s.x f3, x0    # r = 0.0 (acumulador en punto flotante)

    la x4, Y          # x4 apunta al inicio de Y
    la x5, Z          # x5 apunta al inicio de Z
    la x6, X          # x6 apunta al inicio de X

while:
    bge x1, x2, salto   # si i >= N, salir del ciclo

    flw f7, 0(x4)       # cargar Y[i]
    flw f8, 0(x5)       # cargar Z[i]

    fmul.s f10, f7, f8  # f10 = Y[i] * Z[i]
    fadd.s f3, f3, f10  # r = r + (Y[i] * Z[i]) acumulado

    fsw f3, 0(x6)       # X[i] = r (guardar acumulado)

    addi x4, x4, 4      # avanzar puntero Y
    addi x5, x5, 4      # avanzar puntero Z
    addi x6, x6, 4      # avanzar puntero X

    addi x1, x1, 1      # i = i + 1

    j while             # repetir ciclo

salto:
    ecall               # fin del programa