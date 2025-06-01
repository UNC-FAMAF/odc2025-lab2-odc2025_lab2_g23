.ifndef graficos_s
.equ graficos_s, 0

.include "datos.s"

//En este archivo estan todas las funciones que dibujan la imagen

pintar_por_pixel:
        cmp x2, SCREEN_WIDTH // Chequeo si el x es valido
        b.hs return_pintar_pixel
        cmp x3, SCREEN_HEIGH // Chequeo si si el y es valido
        b.hs return_pintar_pixel 
        mov x9, SCREEN_WIDTH
        madd x9, x3, x9, x2 // x9 = (x3 * x9) + x2
        str w1, [x0, x9, lsl #2] // Guardo w1 en x0 + x9*2^2

    return_pintar_pixel:
        br lr 

linea_vertical:
        sub sp, sp, #16 // Guardo el puntero de retorno en el stack
        stur lr, [sp, #8]
        stur x3, [sp] // Guardo en el stack la coordenada en y del comienzo de la linea

    loop_linea_vertical:
        cmp x3, x4
        b.gt end_loop_linea_vertical
        bl pintar_por_pixel
        add x3, x3, #1
        b loop_linea_vertical

    end_loop_linea_vertical:
        ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
        ldur x3, [sp] // Recupero la coordenada en y del comienzo de la linea
        add sp, sp, #16 

        br lr 

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
 
linea_horizontal:
        sub sp, sp, #16 // Guardo el puntero de retorno en el stack
        stur lr, [sp, #8]
        stur x2, [sp] // Guardo en el stack la coordenada en x del comienzo de la linea 

    loop_linea_horizontal:
        cmp x2, x4
        b.gt end_loop_linea_horizontal
        bl pintar_por_pixel
        add x2, x2, #1
        b loop_linea_horizontal

    end_loop_linea_horizontal:
        ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
        ldur x2, [sp] // Recupero la coordenada en x del comienzo de la linea
        add sp, sp, #16 

        br lr 

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

//Dibujar rectangulo    
dibujar_rectangulo:
        sub sp, sp, #16 
        stur lr, [sp, #8] // Guardo el puntero de retorno en el stack
        stur x3, [sp] // Guardo x3 en el stack

    loop_dibujar_rectangulo: // loop para avanzar en y
        cmp x3, x5
        b.gt end_loop_dibujar_rectangulo
        bl linea_horizontal
        add x3, x3, #1
        b loop_dibujar_rectangulo
    
    end_loop_dibujar_rectangulo:
        ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
        ldur x3, [sp] // Recupero x3 del stack
        add sp, sp, #16

        br lr 
/*
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
    ret         
*/
cuadrado:
    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x3, [sp]         // Guardamos x3 (fila actual)

    mov x3, 0
cuadro_filas:
    cmp x3, x9
    b.ge fin_cuadro

    mov x4, 0
cuadro_columnas:
    cmp x4, x9
    b.ge fin_cuadro_col

    add x5, x2, x3
    mov x6, SCREEN_WIDTH
    mul x7, x5, x6
    add x7, x7, x1
    add x7, x7, x4
    lsl x7, x7, 2
    add x8, x20, x7

    stur w10, [x8]

    add x4, x4, 1
    b cuadro_columnas
fin_cuadro_col:
    add x3, x3, 1
    b cuadro_filas
fin_cuadro:
    ldur x3, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr

dibujar_circulo:
        sub sp, sp, #8 // Guardo el puntero de retorno en el stack
        stur lr, [sp]

        mov x15, x2 // Guardo en x15 la condenada del centro en x
        mov x16, x3 // Guardo en x16 la condenada del centro en y
        add x10, x2, x4 // Guardo en x10 la posición final en x
        add x11, x3, x4 // Guardo en x11 la posición final en y
        mul x12, x4, x4 // x12 = r^2 
        sub x2, x2, x4 // Pongo en x2 la posición inicial en x

    loop0_dibujar_circulo: // Loop para avanzar en x
        cmp x2, x10
        b.gt end_loop0_dibujar_circulo
        sub x3, x11, x4
        sub x3, x3, x4 // Pongo en x3 la posición inicial en y

    loop1_dibujar_circulo: // Loop para avanzar en y
        cmp x3, x11
        b.gt end_loop1_dibujar_circulo // Chequeo si hay que pintar el pixel
        sub x13, x2, x15 // x13 = Distancia en x desde el pixel actual al centro
        smull x13, w13, w13 // x13 = w13 * w13  
        sub x14, x3, x16 // x14 = distancia en y desde el pixel actual al centro
        smaddl x13, w14, w14, x13 // x13 = x14*x14 + x13 
        cmp x13, x12
        b.gt f_dibujar_circulo 
        bl pintar_por_pixel 

    f_dibujar_circulo:
        add x3, x3, #1
        b loop1_dibujar_circulo

    end_loop1_dibujar_circulo:
        add x2, x2, #1
        b loop0_dibujar_circulo

    end_loop0_dibujar_circulo:
        mov x2, x15 
        mov x3, x16 
        ldur lr, [sp] // Recupero el puntero de retorno del stack
        add sp, sp, #8 

        br lr


triangulo:
    sub sp, sp, #16 
    stur lr, [sp, #8] // Guardo el puntero de retorno en el stack
    stur x3, [sp] // Guardo x3 en el stack
    mov w1, w19


    loop_triangulo: // loop para avanzar en y
        cmp x3, x5
        b.lt end_loop_triangulo

        bl linea_horizontal
        add x2, x2, #1
        sub x4, x4, #1
        sub x3, x3, #1
        b loop_triangulo
    

    end_loop_triangulo:
        ldur lr, [sp, #8] // Recupero el puntero de retorno del stack
        ldur x3, [sp] // Recupero x3 del stack
        add sp, sp, #16

        br lr 



 
pintar_cielo: 
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
    ldr w23, morado
    mov w1, w23   
    mov x2, 0 
    mov x3, 0 
    mov x4, SCREEN_WIDTH    
    mov x5, SCREEN_HEIGH 
    bl dibujar_rectangulo

    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr

    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr
 
pintar_piso:
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
    
    mov x1, x20
    mov x2, inicio_piso_x  
    mov x3, inicio_piso_y  
    mov x4, final_piso_x  
    mov x5, final_piso_y
    ldr w12, morado_oscuro
    mov w1, w12
    
    bl dibujar_rectangulo 

    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr

 
dibujar_sol:    
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
    
    mov x2, x29 
    mov x3, x30
    mov x4, #40
    bl dibujar_circulo

    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr

pintar_fondo:
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
    
    bl pintar_cielo

    mov x24, SCREEN_WIDTH - 320 // Centro en x, x2
    mov x25, #250  // Centro en y, x3
    mov x26, #40 // Posicion inicial offset x4
    ldr w27, amarillo_anaranjado
    mov w1, w27 // Paso el color como parametro
    bl dibujar_sol

    bl pintar_piso
    

    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr

dibujar_ruta:
    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x3, [sp]
    ldr w19, gris
    mov w1,w19
    mov x3, #479
    mov x5, #250

    mov x2, #100 
    mov x4, #540

loop_ruta:
    cmp x3, x5
    b.lt end_ruta

 // Dibuja línea horizontal desde x2 hasta x4 en y = x3
    bl linea_horizontal

    add x2, x2, #1 // x_izq se acerca al centro
    sub x4, x4, #1 // x_der se acerca al centro
    sub x3,x3, #1
    
    b loop_ruta

end_ruta:
    ldur lr, [sp, #8]
    ldur x3, [sp]
    add sp, sp, #16
    br lr
 

/* 
dibujar_nube:
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
    mov x2, x19
    mov x3, x21
    mov x4, x18
    bl dibujar_circulo
    
    add x2, x2, 15
    add x3, x3, 20
    mov x4, x18
    bl dibujar_circulo
    
    sub x2, x2, 30
    mov x4, x18
    bl dibujar_circulo
    
    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr
   */ 
dibujar_auto:
 sub sp, sp, #16
 stur lr, [sp, #8]
 stur x21, [sp] // si se modifica


 
// --- Carrocería principal ---
    mov x1, 220 // x inicial
    mov x2, 350 // y inicial
    mov x3, 200 // ancho
    mov x4, 60 // alto
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
    mov x1, 300 // x inicial centrado
    mov x2, 385 // y inicial (igual que antes)
    mov x3, 40 // ancho de la patente
    mov x4, 20 // alto de la patente
    movz x10, 0xFFFF, lsl 0
    movk x10, 0x00FF, lsl 16
    bl rectangulo

 //Linea que cruza la carroceria 
    mov x1, 220 // x inicial centrado
    mov x2, 370 // y inicial (igual que antes)
    mov x3, 200 // ancho de la patente
    mov x4, 5 // alto de la patente
    movz x10, 0xFFFF, lsl 0
    movk x10, 0x00FF, lsl 16
    bl rectangulo

 // --- Rueda izquierda ---
    mov x1, 225 // x incial centrado
    mov x2, 410 // y inicial
    mov x3, 30 // ancho de la rueda
    mov x4, 15 // alto de la rueda
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 // --- Rueda derecha ---
    mov x1, 385 // x incial centrado
    mov x2, 410 // y inicial
    mov x3, 30 // ancho de la rueda
    mov x4, 15 // alto de la rueda
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 //-- Triangulo izquierdo 
    mov x1, 390 // x inicial
    mov x2, 320 // y inicial
    mov x3, 30 // base/altura
    movz x10, 0xFFFF, lsl 0
    movk x10, 0x00FF, lsl 16
    bl triangulo_izq // o bl triangulo_der

 // -- Triangulo derecho
    mov x1, 220 // x inicial 
    mov x2, 320 // y inicial 
    mov x3, 30 // base/altura
    movz x10, 0xFFFF, lsl 0
    movk x10, 0x00FF, lsl 16
    bl triangulo_der // o bl triangulo_izq

 // --- Linea techo ---
    mov x1, 250 // x inicial
    mov x2, 317 // y inicial
    mov x3, 140 //ancho
    mov x4, 3 //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 // --- Linea debajo de vidrio ---
    mov x1, 220 // x inicial 
    mov x2, 348 // y inicial
    mov x3, 200 //ancho
    mov x4, 3 //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 // --- Linea de baul ---
    mov x1, 220 // x inicial
    mov x2, 368 // y inicial
    mov x3, 200 //ancho
    mov x4, 3 //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 // --- Linea de baul2 ---
    mov x1, 220
    mov x2, 373
    mov x3, 200 //ancho
    mov x4, 3 //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 // --- Linea de Patente1 ---
    mov x1, 298
    mov x2, 383
    mov x3, 42 //ancho
    mov x4, 3 //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 // --- Linea de Patente2 ---
    mov x1, 298
    mov x2, 403
    mov x3, 43 //ancho
    mov x4, 3 //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 // --- Linea de Patente3 ---
    mov x1, 298
    mov x2, 383
    mov x3, 3 //ancho
    mov x4, 20 //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 // --- Linea de Patente4 ---
    mov x1, 338
    mov x2, 383
    mov x3, 3 //ancho
    mov x4, 20 //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 // --- Linea de Luz1 ---
    mov x1, 338
    mov x2, 383
    mov x3, 3 //ancho
    mov x4, 20 //alto
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

 //Paragolpes
    mov x1, 220 // x inicial centrado
    mov x2, 410 // y inicial (igual que antes)
    mov x3, 200 // ancho de la patente
    mov x4, 3 // alto de la patente
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo


    ldur x21, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr


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

    loop1: bl loop1
    

.endif


