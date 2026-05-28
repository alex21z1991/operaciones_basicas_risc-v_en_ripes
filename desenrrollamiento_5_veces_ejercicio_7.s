.data                                   
A: .float 10.0,9.0,8.0,7.0,6.0,5.0,4.0,3.0,2.0,1.0   # arreglo A de floats
B: .float 1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,0.0    # arreglo B de floats
.text                            
.globl main                         
main:
    li x1,0                             # x1 = 0 -> contador i
    li x2,10                            # x2 = 10 -> cantidad de elementos
    la x3,A                             # x3 apunta al inicio de A
    la x4,B                             # x4 apunta al inicio de B
while:
    bge x1,x2,salto                     # si i >= 10 salir del programa
# PRIMER DESENROLLAMIENTO
    flw f2,0(x4)                        # cargar B[i] en f2
    feq.s x5,f2,f0                     # comparar si B[i]=0.0 == 0.0 es 1 si no 0
    bne x5,x0,salto1                   # si B[i] es 0 saltar 
    flw f1,0(x3)                       # cargar A[i] en f1
    fsub.s f2,f2,f1                   # B[i] = B[i] - A[i]
    fsw f2,0(x4)                      # guardar resultado en B[i]
    
# SEGUNDO DESENROLLAMIENTO
salto1:
    flw f4,4(x4)                      # cargar B[i+1]
    feq.s x6,f4,f0                   # comparar si B[i+1] == 0.0
    bne x6,x0,salto2                 # si es 0 saltar
    flw f3,4(x3)                     # cargar A[i+1]
    fsub.s f4,f4,f3                 # B[i+1] = B[i+1] - A[i+1]
    fsw f4,4(x4)                    # guardar resultado

# TERCER DESENROLLAMIENTO
salto2:
    flw f6,8(x4)                    # cargar B[i+2]
    feq.s x7,f6,f0                 # comparar si B[i+2] == 0.0
    bne x7,x0,salto3               # si es 0 saltar
    flw f5,8(x3)                   # cargar A[i+2]
    fsub.s f6,f6,f5               # B[i+2] = B[i+2] - A[i+2]
    fsw f6,8(x4)                  # guardar resultado

# CUARTO DESENROLLAMIENTO
salto3:
    flw f8,12(x4)                 # cargar B[i+3]
    feq.s x8,f8,f0               # comparar si B[i+3] == 0.0
    bne x8,x0,salto4             # si es 0 saltar
    flw f7,12(x3)                # cargar A[i+3]
    fsub.s f8,f8,f7             # B[i+3] = B[i+3] - A[i+3]
    fsw f8,12(x4)               # guardar resultado

# QUINTO DESENROLLAMIENTO
salto4:
    flw f10,16(x4)              # cargar B[i+4]
    feq.s x9,f10,f0            # comparar si B[i+4] == 0.0
    bne x9,x0,salto5           # si es 0 saltar
    flw f9,16(x3)              # cargar A[i+4]
    fsub.s f10,f10,f9         # B[i+4] = B[i+4] - A[i+4]
    fsw f10,16(x4)            # guardar resultado
    
salto5:
    addi x3,x3,20             # avanzar A en 5 floats
    addi x4,x4,20             # avanzar B en 5 floats
    addi x1,x1,5              # i = i + 5
    j while                   # volver al while
salto:
    li a7,10                  # codigo para terminar programa
    ecall                     # finalizar ejecucion