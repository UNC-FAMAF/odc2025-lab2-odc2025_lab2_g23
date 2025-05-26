    .equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34
   
    .global rectangulo
    .global cuadrado
    .global trapezoide
    .global trapezoide_centro
    .global triangulo_izq
    .global triangulo_der
    
 

InfLoop:
    b InfLoop                         // Bucle infinito para que el programa no termine

// ------------------- SUBRUTINA CUADRADO -------------------
// Dibuja un cuadrado de lado x9 en (x1, x2) con color w10
    // x0 = framebuffer base
    // x1 = esquina superior izquierda x
    // x2 = esquina superior izquierda y
    // x9 = LADO
    // w10 = color

cuadrado:
    mov x3, 0                  // x3 = fila actual
cuadro_filas:
    cmp x3, x9                 // ¿Llegamos al lado?
    b.ge fin_cuadro

    mov x4, 0                  // x4 = columna actual
cuadro_columnas:
    cmp x4, x9
    b.ge fin_cuadro_col

    // Calcula dirección del pixel actual
    add x5, x2, x3             // y + fila
    mov x6, SCREEN_WIDTH
    mul x7, x5, x6             // (y + fila) * ancho pantalla
    add x7, x7, x1             // + x inicial
    add x7, x7, x4             // + columna
    lsl x7, x7, 2              // *4 (32 bits por pixel)
    add x8, x0, x7             // dirección absoluta

    stur w10, [x8]             // Escribe color

    add x4, x4, 1
    b cuadro_columnas
fin_cuadro_col:
    add x3, x3, 1
    b cuadro_filas
fin_cuadro:
    ret

// ------------------- SUBRUTINA RECTANGULO -------------------
// Dibuja un rectángulo de ancho x3 y alto x4 en (x1, x2) con color w10
    // x0 = framebuffer base
    // x1 = esquina superior izquierda x
    // x2 = esquina superior izquierda y
    // x3 = ancho
    // x4 = alto
    // w10 = color
rectangulo:
    mov x5, 0                  // x5 = fila actual
rect_filas:
    cmp x5, x4
    b.ge fin_rect

    mov x6, 0                  // x6 = columna actual
rect_columnas:
    cmp x6, x3
    b.ge fin_rect_col

    // Calcula dirección del pixel actual
    add x7, x2, x5
    mov x8, SCREEN_WIDTH
    mul x9, x7, x8
    add x9, x9, x1
    add x9, x9, x6
    lsl x9, x9, 2
    add x11, x0, x9

    stur w10, [x11]

    add x6, x6, 1
    b rect_columnas
fin_rect_col:
    add x5, x5, 1
    b rect_filas
fin_rect:
    ret

// ------------------- SUBRUTINA TRIANGULO IZQ -------------------
// Dibuja un triángulo rectángulo con cateto izquierdo en (x1, x2), tamaño x3, color w10
    // x0 = framebuffer base
    // x1 = x inicial (esquina superior izquierda)
    // x2 = y inicial (esquina superior izquierda)
    // x3 = tamaño base/altura (en píxeles)
    // w10 = color
triangulo_izq:
    mov x4, 0                  // x4 = fila actual
triang_izq_filas:
    cmp x4, x3
    b.ge fin_triang_izq

    mov x5, 0                  // x5 = columna actual
triang_izq_columnas:
    cmp x5, x4                 // Solo hasta la diagonal
    b.gt fin_triang_izq_col

    // Calcula dirección del pixel actual
    add x6, x2, x4
    mov x7, SCREEN_WIDTH
    mul x8, x6, x7
    add x8, x8, x1
    add x8, x8, x5
    lsl x8, x8, 2
    add x9, x0, x8

    stur w10, [x9]

    add x5, x5, 1
    b triang_izq_columnas
fin_triang_izq_col:
    add x4, x4, 1
    b triang_izq_filas
fin_triang_izq:
    ret

// ------------------- SUBRUTINA TRIANGULO DER -------------------
// Dibuja un triángulo rectángulo con cateto derecho en (x1, x2), tamaño x3, color w10
    // x0 = framebuffer base
    // x1 = x inicial (esquina superior derecha de la base)
    // x2 = y inicial (esquina superior)
    // x3 = tamaño base/altura (en píxeles)
    // w10 = color
triangulo_der:
    mov x4, 0
triang_der_filas:
    cmp x4, x3
    b.ge fin_triang_der

    mov x5, 0
triang_der_columnas:
    cmp x5, x4
    b.gt fin_triang_der_col

    // Calcula dirección del pixel actual
    add x6, x2, x4
    mov x7, SCREEN_WIDTH
    mul x8, x6, x7
    add x8, x8, x1
    sub x9, x3, x5
    sub x9, x9, 1
    add x8, x8, x9
    lsl x8, x8, 2
    add x11, x0, x8

    stur w10, [x11]

    add x5, x5, 1
    b triang_der_columnas
fin_triang_der_col:
    add x4, x4, 1
    b triang_der_filas
fin_triang_der:
    ret

// ------------------- SUBRUTINA TRAPEZOIDE -------------------
// Dibuja un trapecio entre dos bases horizontales (x3 abajo, x4 arriba), altura x5, color w10
    // x0 = framebuffer base
    // x1 = x inicial base inferior (abajo)
    // x2 = y inicial base inferior (abajo)
    // x3 = ancho base inferior
    // x4 = ancho base superior
    // x5 = altura (en píxeles)
    // w10 = color
trapezoide:
    mov x6, 0                  // x6 = fila actual
trap_filas:
    cmp x6, x5
    b.ge fin_trap

    // Interpolación lineal para el ancho de la fila
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
    ret

// ------------------- SUBRUTINA TRAPEZOIDE CENTRO -------------------
// Dibuja un trapecio centrado en x1, desde y2, con anchos x3 y x4, altura x5, color w10
    // x0 = framebuffer base
    // x1 = x_centro_arriba
    // x2 = y_arriba
    // x3 = ancho_arriba
    // x4 = ancho_abajo
    // x5 = altura
    // w10 = color
trapezoide_centro:
    mov x6, 0
trap_centro_filas:
    cmp x6, x5
    b.ge fin_trap_centro

    // Interpolación lineal para el ancho de la fila
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
    ret

