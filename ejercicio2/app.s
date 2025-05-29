.equ SCREEN_WIDTH, 		640           // Ancho de la pantalla en píxeles
.equ SCREEN_HEIGH, 		480           // Alto de la pantalla en píxeles
.equ BITS_PER_PIXEL,  	32            // Bits por píxel (4 bytes)

.equ GPIO_BASE,      0x3f200000
.equ GPIO_GPFSEL0,   0x00
.equ GPIO_GPLEV0,    0x34


.globl main

.globl main
main:
    mov x20, x0       // dirección framebuffer

    // Configuración inicial
    mov x21, 250      // offset líneas horizontales
    mov x15, 240      // offset cuadrados
    mov x22, 50       // separación entre cuadrados
    mov x23, 10       // lado del cuadrado
    movz x25, 0xFFFF, lsl 0
    movk x25, 0x00FF, lsl 16  // blanco

    
 
animacion_loop:
    // 🧽 Borrar cuadrados anteriores
    mov x26, 0
    mov x27, x21
borrar_loop:
    mov x0, x20
    mov x1, 320 - 5
    mov x2, x27
    mov x9, x23
    movz x10, 0x3030, lsl 0         // gris ruta
    movk x10, 0xFF30, lsl 16
    bl cuadrado

    add x27, x27, x22
    cmp x27, 480
    b.lt borrar_loop

    //  Fondo base (verde)
    mov x1, 1
    mov x2, 220
    mov x3, 185
    mov x4, 260
    movz x10, 0xC040, lsl 0
    movk x10, 0x0042, lsl 16
    bl rectangulo
    
    mov x1, 455
    mov x2, 220
    mov x3, 185
    mov x4, 260
    movz x10, 0xC040, lsl 0
    movk x10, 0x0042, lsl 16
 
    bl rectangulo

// Banquinas
    mov x1, 185
    mov x2, 210
    mov x3, 30
    mov x4, 270
    movz x10, 0x4040, lsl 0
    movk x10, 0xFF40, lsl 16
    bl rectangulo
    mov x1, 425
    bl rectangulo
    //  Ruta central (gris)
    mov x1, 215
    mov x2, 210
    mov x3, 210
    mov x4, 270
    movz x10, 0x3030, lsl 0
    movk x10, 0xFF30, lsl 16
    bl rectangulo

    // Columnas
    mov x1, 130
    mov x2, 40
    mov x3, 10
    mov x4, 180
    movz x10, 0x8080, lsl 0
    movk x10, 0x8080, lsl 16
    bl rectangulo
    mov x1, 500
    bl rectangulo

    // Cartel
    mov x1, 140
    mov x2, 40
    mov x3, 360
    mov x4, 90
    movz x10, 0x7A3D, lsl 0      
    movk x10, 0xFF00, lsl 16 
    bl rectangulo
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
//Fin O

//Inicio D
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
//FIN D

//INICIO C
    mov x1, 285
    mov x2, 60
    mov x3, 40
    mov x4, 5
    bl rectangulo

    mov x2,100
    bl rectangulo

    mov x2, 60
    mov x3, 5
    mov x4, 40
    bl rectangulo
//FIN C

//INICIO 2
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
//FIN 2

//INICIO 0

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

    //FIN 0

    
//INICIO 2
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
//FIN 2

//INICIO 5

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

//FIN 5


    //  Líneas verdes horizontales
    mov x24, x21
    mov x19, 42       // separación
    mov x28, 5        // grosor
lineas_horizontales:
    cmp x24, 480
    b.ge fin_lineas_h

    mov x1, 455
    mov x2, x24
    mov x3, 370
    mov x4, x28
    movz x10, 0x8B22, lsl 0
    movk x10, 0xFF22, lsl 16
    bl rectangulo

    

    add x24, x24, x19
    b lineas_horizontales
fin_lineas_h:


   
    // Dibujar nuevos cuadrados
    mov x26, 0
    mov x27, x21
cuadrado_loop:
    mov x0, x20
    mov x1, 320 - 5
    mov x2, x27
    mov x9, x23
    mov x10, x25
    bl cuadrado
    
    add x27, x27, x22
    cmp x27, 480
    b.lt cuadrado_loop
    
    
    // --- Carrocería principal ---
    mov x1, 220         // x inicial
    mov x2, 350         // y inicial
    mov x3, 200         // ancho
    mov x4, 60          // alto
    movz x10, 0x00A0, lsl 0
    movk x10, 0x0070, lsl 16
    bl rectangulo

    // --- Vidrio trasero ---
    mov x1, 250
    mov x2, 320
    mov x3, 140
    mov x4, 30
    movz x10, 0xE0FF, lsl 0
    movk x10, 0x00A0, lsl 16
    bl rectangulo

    // --- Luces traseras (izquierda) ---
    mov x1, 230
    mov x2, 390
    mov x3, 30
    mov x4, 10
    movz x10, 0x4080, lsl 0
    movk x10, 0x00FF, lsl 16
    bl rectangulo

    // --- Luces traseras (derecha) ---
    mov x1, 380
    mov x2, 390
    mov x3, 30
    mov x4, 10
    movz x10, 0x4080, lsl 0
    movk x10, 0x00FF, lsl 16
    bl rectangulo

    // --- Patente (blanco) centrada ---
    mov x1, 300        // x inicial centrado
    mov x2, 385        // y inicial (igual que antes)
    mov x3, 40         // ancho de la patente
    mov x4, 20         // alto de la patente
    movz x10, 0xFFFF, lsl 0
    movk x10, 0x00FF, lsl 16
    bl rectangulo

    //Linea que cruza la carroceria 
    mov x1, 220        // x inicial centrado
    mov x2, 370        // y inicial (igual que antes)
    mov x3, 200         // ancho de la patente
    mov x4, 5         // alto de la patente
    movz x10, 0xFFFF, lsl 0
    movk x10, 0x00FF, lsl 16
    bl rectangulo

    // --- Rueda izquierda ---
    mov x1, 225      // x incial centrado
    mov x2, 410      // y inicial
    mov x3, 30       // ancho de la rueda
    mov x4, 15       // alto de la rueda
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    // --- Rueda derecha ---
    mov x1, 385     // x incial centrado
    mov x2, 410     // y inicial
    mov x3, 30      // ancho de la rueda
    mov x4, 15      // alto de la rueda
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    //-- Triangulo izquierdo 
    mov x1, 390    // x inicial
    mov x2, 320      // y inicial
    mov x3, 30       // base/altura
    movz x10, 0xFFFF, lsl 0
    movk x10, 0x00FF, lsl 16
    bl triangulo_izq // o bl triangulo_der

    // -- Triangulo derecho
    mov x1, 220     // x inicial 
    mov x2, 320      // y inicial 
    mov x3, 30       // base/altura
    movz x10, 0xFFFF, lsl 0
    movk x10, 0x00FF, lsl 16
    bl triangulo_der // o bl triangulo_izq

    // --- Linea techo ---
    mov x1, 250   // x inicial
    mov x2, 317   // y inicial
    mov x3, 140  //ancho
    mov x4, 3  //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    // --- Linea debajo de vidrio ---
    mov x1, 220  // x inicial 
    mov x2, 348  // y inicial
    mov x3, 200  //ancho
    mov x4, 3  //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    // --- Linea de baul ---
    mov x1, 220  // x inicial
    mov x2, 368  // y inicial
    mov x3, 200  //ancho
    mov x4, 3  //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    // --- Linea de baul2 ---
    mov x1, 220
    mov x2, 373
    mov x3, 200  //ancho
    mov x4, 3  //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    // --- Linea de Patente1 ---
    mov x1, 298
    mov x2, 383
    mov x3, 42  //ancho
    mov x4, 3  //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

     // --- Linea de Patente2 ---
    mov x1, 298
    mov x2, 403
    mov x3, 43  //ancho
    mov x4, 3  //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

     // --- Linea de Patente3 ---
    mov x1, 298
    mov x2, 383
    mov x3, 3  //ancho
    mov x4, 20  //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    // --- Linea de Patente4 ---
    mov x1, 338
    mov x2, 383
    mov x3, 3  //ancho
    mov x4, 20  //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    // --- Linea de Luz1 ---
    mov x1, 338
    mov x2, 383
    mov x3, 3  //ancho
    mov x4, 20  //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    //Paragolpes
    mov x1, 220        // x inicial centrado
    mov x2, 410        // y inicial (igual que antes)
    mov x3, 200         // ancho de la patente
    mov x4, 3         // alto de la patente
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    // Actualizar posiciones
    add x21, x21, 5
    cmp x21, 260
    b.lt skip_reset_lineas
    sub x21, x21, x22
skip_reset_lineas:

    add x15, x15, 5
    cmp x15, 240
    b.lt skip_reset_cuadros
    sub x15, x15, x22
skip_reset_cuadros:

    // Delay
    mov x27, 0x2700000
delay_loop:
    subs x27, x27, 1
    b.ne delay_loop

    b animacion_loop



// ------------------- SUBRUTINA CUADRADO -------------------
cuadrado:
    // x0 = framebuffer base
    // x1 = esquina superior izquierda x
    // x2 = esquina superior izquierda y
    // x9 = LADO
    // w10 = color

    mov x3, 0                         // x3 = fila actual (Y dentro del cuadrado)
cuadro_filas:
    cmp x3, x9                        // ¿fila >= LADO?
    b.ge fin_cuadro                   // Si sí, termina el cuadrado

    mov x4, 0                         // x4 = columna actual (X dentro del cuadrado)
cuadro_columnas:
    cmp x4, x9                        // ¿columna >= LADO?
    b.ge fin_cuadro_col               // Si sí, termina la fila

    add x5, x2, x3                    // x5 = y real (y inicial + fila)
    mov x6, SCREEN_WIDTH
    mul x7, x5, x6                    // x7 = (y real) * SCREEN_WIDTH
    add x7, x7, x1                    // x7 = (y real) * SCREEN_WIDTH + x inicial
    add x7, x7, x4                    // x7 = ... + columna
    lsl x7, x7, 2                     // x7 = ... * 4 (bytes por píxel)
    add x8, x20, x7                   // x8 = dirección final del píxel

    stur w10, [x8]                    // Pinta el píxel con el color actual

    add x4, x4, 1                     // Siguiente columna
    b cuadro_columnas                 // Repite la fila
fin_cuadro_col:
    add x3, x3, 1                     // Siguiente fila
    b cuadro_filas                    // Repite el cuadrado
fin_cuadro:
    ret                               // Retorna al main

//---------------- SUBRUTINA RECTÁNGULO -------------------
rectangulo:
    // x0 = framebuffer base
    // x1 = esquina x
    // x2 = esquina y
    // x3 = ancho
    // x4 = alto
    // w10 = color

    mov x5, 0                          // fila actual
    mov x8, SCREEN_WIDTH              // cachear SCREEN_WIDTH

rect_filas:
    cmp x5, x4
    b.ge fin_rect

    // calcular dirección base de la fila
    add x6, x2, x5                    // y + fila
    mul x6, x6, x8                    // y * SCREEN_WIDTH
    add x6, x6, x1                    // y * SCREEN_WIDTH + x
    lsl x6, x6, 2                     // *= 4 bytes por pixel
    add x7, x0, x6                    // dirección base de fila

    mov x9, 0                         // columna actual
rect_columnas:
    cmp x9, x3
    b.ge fin_rect_col

    str w10, [x7, x9, lsl #2]         // escribe color en (x9 * 4) offset
    add x9, x9, 1
    b rect_columnas

fin_rect_col:
    add x5, x5, 1
    b rect_filas

fin_rect:
    ret


// ------------------- SUBRUTINA TRIÁNGULO 1-------------------
triangulo_izq:
    // x0 = framebuffer base
    // x1 = x inicial (esquina superior izquierda)
    // x2 = y inicial (esquina superior izquierda)
    // x3 = tamaño base/altura (en píxeles)
    // w10 = color

    mov x4, 0                  // fila actual (y)
triang_izq_filas:
    cmp x4, x3
    b.ge fin_triang_izq

    // Para cada fila, la cantidad de columnas es x4 + 1
    mov x5, 0                  // columna actual (x)
triang_izq_columnas:
    cmp x5, x4
    b.gt fin_triang_izq_col

    // Calcula dirección del píxel: ((y0 + fila) * SCREEN_WIDTH + (x0 + columna)) * 4
    add x6, x2, x4             // y real
    mov x7, SCREEN_WIDTH
    mul x8, x6, x7
    add x8, x8, x1
    add x8, x8, x5
    lsl x8, x8, 2
    add x9, x20, x8

    stur w10, [x9]             // pinta el píxel

    add x5, x5, 1
    b triang_izq_columnas
fin_triang_izq_col:
    add x4, x4, 1
    b triang_izq_filas
fin_triang_izq:
    ret



// ------------------- SUBRUTINA TRIÁNGULO 2-------------------
triangulo_der:
    // x0 = framebuffer base
    // x1 = x inicial (esquina superior derecha de la base)
    // x2 = y inicial (esquina superior)
    // x3 = tamaño base/altura (en píxeles)
    // w10 = color

    mov x4, 0                  // fila actual (y)
triang_der_filas:
    cmp x4, x3
    b.ge fin_triang_der

    // Para cada fila, la cantidad de columnas es x4 + 1
    mov x5, 0                  // columna actual (x)
triang_der_columnas:
    cmp x5, x4
    b.gt fin_triang_der_col

    // Calcula dirección del píxel: ((y0 + fila) * SCREEN_WIDTH + (x0 + (base - columna - 1))) * 4
    add x6, x2, x4             // y real
    mov x7, SCREEN_WIDTH
    mul x8, x6, x7
    add x8, x8, x1
    sub x9, x3, x5
    sub x9, x9, 1
    add x8, x8, x9
    lsl x8, x8, 2
    add x11, x20, x8           // Usa x11 para la dirección

    stur w10, [x11]            // pinta el píxel

    add x5, x5, 1
    b triang_der_columnas
fin_triang_der_col:
    add x4, x4, 1
    b triang_der_filas
fin_triang_der:
    ret



// ------------------- SUBRUTINA TRAPEZOIDE -------------------
trapezoide:
    // x0 = framebuffer base
    // x1 = x inicial base inferior (abajo)
    // x2 = y inicial base inferior (abajo)
    // x3 = ancho base inferior
    // x4 = ancho base superior
    // x5 = altura (en píxeles)
    // w10 = color

    mov x6, 0                  // x6 = fila actual (desde abajo hacia arriba)
trap_filas:
    cmp x6, x5
    b.ge fin_trap

    // Interpolación lineal del ancho y x inicial para cada fila
    // ancho_fila = base_inf + ((base_sup - base_inf) * fila) / altura
    sub x7, x4, x3             // x7 = base_sup - base_inf
    mul x8, x7, x6             // x8 = (base_sup - base_inf) * fila
    sdiv x8, x8, x5            // x8 = ... / altura
    add x9, x3, x8             // x9 = ancho_fila

    // x inicial de la fila: x_inf + ((x_sup - x_inf) * fila) / altura
    // Si x_inf == x_sup, esto es constante
    mov x11, x1                // x inicial base inferior
    mov x12, x1                // x inicial base superior (ajusta si quieres mover el trapecio)
    sub x13, x12, x11          // x13 = x_sup - x_inf
    mul x14, x13, x6           // x14 = (x_sup - x_inf) * fila
    sdiv x14, x14, x5          // x14 = ... / altura
    add x15, x11, x14          // x15 = x inicial de la fila

    // Dibuja la fila como un rectángulo de 1 píxel de alto
    mov x16, 0                 // columna actual
trap_columnas:
    cmp x16, x9
    b.ge fin_trap_col

    // Calcula dirección: ((y_inf - fila) * SCREEN_WIDTH + (x_ini_fila + columna)) * 4
    sub x17, x2, x6            // y real (de abajo hacia arriba)
    mov x18, SCREEN_WIDTH
    mul x19, x17, x18
    add x19, x19, x15
    add x19, x19, x16
    lsl x19, x19, 2
    add x20, x0, x19

    stur w10, [x20]            // pinta el píxel

    add x16, x16, 1
    b trap_columnas
fin_trap_col:
    add x6, x6, 1
    b trap_filas
fin_trap:
    ret



// ------------------- SUBRUTINA TRAPEZOIDE CENTRO -------------------
trapezoide_centro:
    // x0 = framebuffer base
    // x1 = x_centro_arriba
    // x2 = y_arriba
    // x3 = ancho_arriba
    // x4 = ancho_abajo
    // x5 = altura
    // w10 = color

    mov x6, 0                  // x6 = fila actual (de arriba hacia abajo)
trap_centro_filas:
    cmp x6, x5
    b.ge fin_trap_centro

    // Interpolación lineal del ancho para cada fila
    // ancho_fila = ancho_arriba + ((ancho_abajo - ancho_arriba) * fila) / altura
    sub x7, x4, x3             // x7 = ancho_abajo - ancho_arriba
    mul x8, x7, x6             // x8 = (ancho_abajo - ancho_arriba) * fila
    sdiv x8, x8, x5            // x8 = ... / altura
    add x9, x3, x8             // x9 = ancho_fila

    // x inicial de la fila: x_centro_arriba - ancho_arriba/2 + ((x_centro_abajo - x_centro_arriba) * fila) / altura
    // Pero aquí el centro de abajo es igual al de arriba, así que solo desplazamos para centrar cada fila
    lsr x17, x9, 1             // x17 = ancho_fila / 2
    sub x11, x1, x17           // x11 = x inicial de la fila (centrado)

    // Dibuja la fila como un rectángulo de 1 píxel de alto
    mov x12, 0                 // columna actual
trap_centro_columnas:
    cmp x12, x9
    b.ge fin_trap_centro_col

    // Calcula dirección: ((y_arriba + fila) * SCREEN_WIDTH + (x_ini_fila + columna)) * 4
    add x13, x2, x6            // y real (de arriba hacia abajo)
    mov x14, SCREEN_WIDTH
    mul x15, x13, x14
    add x15, x15, x11
    add x15, x15, x12
    lsl x15, x15, 2
    add x16, x0, x15

    stur w10, [x16]            // pinta el píxel

    add x12, x12, 1
    b trap_centro_columnas
fin_trap_centro_col:
    add x6, x6, 1
    b trap_centro_filas
fin_trap_centro:
    ret



diagonal:
    // x0 = framebuffer base
    // x1 = x inicial
    // x2 = y inicial
    // x3 = longitud
    // w10 = color

    mov x4, 0                 // contador de píxeles

diagonal_loop:
    cmp x4, x3
    b.ge fin_diagonal

    // Coordenadas del píxel actual
    add x5, x1, x4            // x = x1 + i
    add x6, x2, x4            // y = y1 + i

    // Dirección: (y * SCREEN_WIDTH + x) * 4
    mov x7, SCREEN_WIDTH
    mul x8, x6, x7
    add x8, x8, x5
    lsl x8, x8, 2
    add x9, x0, x8

    str w10, [x9]             // pintar píxel

    add x4, x4, 1
    b diagonal_loop

fin_diagonal:
    ret
