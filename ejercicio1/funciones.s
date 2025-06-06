    .ifndef funciones_s
    .equ funciones_s, 0
    .include "datos.s"
    .include "Graficos.s"
palabra:
    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x21, [sp] // si se modifica x21, lo guardamos

    // INICIO O
    mov x1, 150
    mov x2, 60
    mov x3, 50
    mov x4, 5
    movz x10, 0xFFFF, lsl 0      
    movk x10, 0xFFFF, lsl 16 
    bl rectangulo

    mov x2, 100 
    bl rectangulo

    mov x1, 150
    mov x2, 60
    mov x3, 5
    mov x4, 40
    bl rectangulo

    mov x1, 195
    bl rectangulo
    // FIN O

    // INICIO D
    mov x1, 215
    mov x4, 45
    bl rectangulo

    mov x1, 265
    mov x4, 45
    bl rectangulo

    mov x1, 210
    mov x2, 60
    mov x3, 60
    mov x4, 5
    bl rectangulo

    mov x2, 100
    bl rectangulo
    // FIN D

    // INICIO C
    mov x1, 285
    mov x2, 60
    mov x3, 40
    mov x4, 5
    bl rectangulo

    mov x2, 100
    bl rectangulo

    mov x2, 60
    mov x3, 5
    mov x4, 40
    bl rectangulo
    // FIN C

    // INICIO 2
    mov x1, 365
    mov x2, 60
    mov x3, 5
    mov x4, 20
    bl rectangulo

    mov x1, 345
    mov x2, 80
    mov x3, 5
    mov x4, 20
    bl rectangulo

    mov x1, 345
    mov x2, 80
    mov x3, 25
    mov x4, 5
    bl rectangulo

    mov x1, 345
    mov x2, 60
    mov x3, 20
    mov x4, 5
    bl rectangulo

    mov x1, 345
    mov x2, 100
    mov x3, 25
    mov x4, 5
    bl rectangulo
    // FIN 2

    // INICIO 0
    mov x1, 375
    mov x2, 60
    mov x3, 25
    mov x4, 5
    movz x10, 0xFFFF, lsl 0      
    movk x10, 0xFFFF, lsl 16 
    bl rectangulo

    mov x2, 100 
    bl rectangulo

    mov x1, 375
    mov x2, 60
    mov x3, 5
    mov x4, 45
    bl rectangulo

    mov x1, 400
    bl rectangulo
    // FIN 0

    // INICIO 2
    mov x1, 430
    mov x2, 60
    mov x3, 5
    mov x4, 20
    bl rectangulo

    mov x1, 410
    mov x2, 80
    mov x3, 5
    mov x4, 20
    bl rectangulo

    mov x1, 410
    mov x2, 80
    mov x3, 25
    mov x4, 5
    bl rectangulo

    mov x1, 410
    mov x2, 60
    mov x3, 20
    mov x4, 5
    bl rectangulo

    mov x1, 410
    mov x2, 100
    mov x3, 25
    mov x4, 5
    bl rectangulo
    // FIN 2

    // INICIO 5
    mov x1, 440
    mov x2, 60
    mov x3, 5
    mov x4, 20
    bl rectangulo

    mov x1, 460
    mov x2, 80
    mov x3, 5
    mov x4, 20
    bl rectangulo

    mov x1, 440
    mov x2, 80
    mov x3, 25
    mov x4, 5
    bl rectangulo

    mov x1, 445
    mov x2, 60
    mov x3, 20
    mov x4, 5
    bl rectangulo

    mov x1, 440
    mov x2, 100
    mov x3, 25
    mov x4, 5
    bl rectangulo
    // FIN 5

    ldur x21, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr
  
  
// ------------------- SUBRUTINA TRAPEZOIDE -------------------
trapezoide:
    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x30, [sp] // si usás registros temporales importantes, podés guardar más

    mov x6, 0
trap_filas:
    cmp x6, x5
    b.ge fin_trap

    sub x7, x4, x3
    mul x8, x7, x6
    sdiv x8, x8, x5
    add x9, x3, x8

    mov x11, x1
    mov x12, x1
    sub x13, x12, x11
    mul x14, x13, x6
    sdiv x14, x14, x5
    add x15, x11, x14

    mov x16, 0
trap_columnas:
    cmp x16, x9
    b.ge fin_trap_col

    sub x17, x2, x6
    mov x18, SCREEN_WIDTH
    mul x19, x17, x18
    add x19, x19, x15
    add x19, x19, x16
    lsl x19, x19, 2
    add x20, x0, x19

    stur w10, [x20]

    add x16, x16, 1
    b trap_columnas
fin_trap_col:
    add x6, x6, 1
    b trap_filas
fin_trap:
    ldur x30, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr

// ------------------- SUBRUTINA TRAPEZOIDE CENTRO -------------------
trapezoide_centro:
    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x30, [sp]

    mov x6, 0
trap_centro_filas:
    cmp x6, x5
    b.ge fin_trap_centro

    sub x7, x4, x3
    mul x8, x7, x6
    sdiv x8, x8, x5
    add x9, x3, x8

    lsr x17, x9, 1
    sub x11, x1, x17

    mov x12, 0
trap_centro_columnas:
    cmp x12, x9
    b.ge fin_trap_centro_col

    add x13, x2, x6
    mov x14, SCREEN_WIDTH
    mul x15, x13, x14
    add x15, x15, x11
    add x15, x15, x12
    lsl x15, x15, 2
    add x16, x0, x15

    stur w10, [x16]

    add x12, x12, 1
    b trap_centro_columnas
fin_trap_centro_col:
    add x6, x6, 1
    b trap_centro_filas
fin_trap_centro:
    ldur x30, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr

diagonal:
    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x30, [sp]

    mov x4, 0
diagonal_loop:
    cmp x4, x3
    b.ge fin_diagonal

    add x5, x1, x4
    add x6, x2, x4

    mov x7, SCREEN_WIDTH
    mul x8, x6, x7
    add x8, x8, x5
    lsl x8, x8, 2
    add x9, x0, x8

    str w10, [x9]

    add x4, x4, 1
    b diagonal_loop
fin_diagonal:
    ldur x30, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr

.endif


