.equ SCREEN_WIDTH, 		640           // Ancho de la pantalla en píxeles
.equ SCREEN_HEIGH, 		480           // Alto de la pantalla en píxeles
.equ BITS_PER_PIXEL,  	32            // Bits por píxel (4 bytes)

.equ GPIO_BASE,      0x3f200000
.equ GPIO_GPFSEL0,   0x00
.equ GPIO_GPLEV0,    0x34

.extern auto 
.extern edificios
.globl main

main:
    mov x20, x0                       // Guarda la dirección base del framebuffer en x20

   /*
   DIBUJO INICIAL
    // --- Rectángulo verde ---
    mov x1, 1                       // x inicial del rectángulo
    mov x2, 260                        // y inicial del rectángulo
    mov x3, 640                      // ancho del rectángulo
    mov x4, 220                        // alto del rectángulo
    movz x10, 0xC040, lsl 0          // Carga parte baja del color verde en x10
    movk x10, 0x0042, lsl 16          // Completa el color verde en x10 (w10)
    bl rectangulo                     // Llama a la subrutina rectángulo
    
    

     // --  Camino 
    mov x1, 320      // x_centro_arriba
    mov x2, 260      // y_arriba
    mov x3, 100      // ancho_arriba
    mov x4, 400      // ancho_abajo
    mov x5, 220      // altura
    movz x10, 0x8080, lsl 0
    movk x10, 0x0080, lsl 16
    bl trapezoide_centro

     // --  linea 
    mov x1, 320      // x_centro_arriba (igual que el camino)
    mov x2, 260      // y_arriba (igual que el camino)
    mov x3, 12      // ancho_arriba (proporcional: 100/5)
    mov x4, 24       // ancho_abajo (proporcional: 400/5)
    mov x5, 20       // altura (proporcional: 220/5)
    movz x10, 0xFFFF, lsl 0   // blanco
    movk x10, 0x00FF, lsl 16
    bl trapezoide_centro
    
     // --  linea 2
    mov x1, 320      // x_centro_arriba (igual que el camino)
    mov x2, 300      // y_arriba (igual que el camino)
    mov x3, 16      // ancho_arriba (proporcional: 100/5)
    mov x4, 24       // ancho_abajo (proporcional: 400/5)
    mov x5, 20       // altura (proporcional: 220/5)
    movz x10, 0xFFFF, lsl 0   // blanco
    movk x10, 0x00FF, lsl 16
    bl trapezoide_centro

    // -- Linea 3
    mov x1, 320      // x_centro_arriba (igual que el camino)
    mov x2, 420      // y_arriba (igual que el camino)
    mov x3, 20      // ancho_arriba (proporcional: 100/5)
    mov x4, 33       // ancho_abajo (proporcional: 400/5)
    mov x5, 30       // altura (proporcional: 220/5)
    movz x10, 0xFFFF, lsl 0   // blanco
    movk x10, 0x00FF, lsl 16
    bl trapezoide_centro

        // Franja 1
    mov x1, 385
    mov x2, 390
    mov x3, 30
    mov x4, 10
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

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
    mov x4, 15
    movz x10, 0x4080, lsl 0
    movk x10, 0x00FF, lsl 16
    bl rectangulo

    // --- Luces traseras (derecha) ---
    mov x1, 380
    mov x2, 390
    mov x3, 30
    mov x4, 15
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
    mov x1, 225
    mov x2, 410
    mov x3, 30
    mov x4, 10
    movz x10, 0x0000, lsl 0
    movk x10, 0x0000, lsl 16
    bl rectangulo

    // --- Rueda derecha ---
    mov x1, 385
    mov x2, 410
    mov x3, 30
    mov x4, 10
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
 */
     
    // =============================================
    // ANIMACIÓN 
    // =============================================
    mov x21, 260                      // y inicial de la primera línea
    mov x22, 42                       // separación entre líneas (píxeles)
    mov x23, 5                        // grosor de cada línea (píxeles)
    mov x24, 0xFFFF                   // color blanco (parte baja)
    movk x24, 0x00FF, lsl 16          // color blanco (parte alta)
    
    
animacion_loop:
    // --- Redibujar fondo (para "limpiar" las líneas anteriores) ---
    mov x0, x20                       // dirección base del framebuffer
    movz x10, 0xC7, lsl 16            // color de fondo rosa
    movk x10, 0x1585, lsl 00
    mov x2, SCREEN_HEIGH
fondo_loop1:
    mov x1, SCREEN_WIDTH
fondo_loop0:
    stur w10,[x0]
    add x0,x0,4
    sub x1,x1,1
    cbnz x1,fondo_loop0
    sub x2,x2,1
    cbnz x2,fondo_loop1

    
    // --- Volver a dibujar todos los elementos estáticos ---
    // Rectángulo verde base
    
    
    mov x1, 1
    mov x2, 220
    mov x3, 640
    mov x4, 260
    movz x10, 0xC040, lsl 0
    movk x10, 0x0042, lsl 16
    bl rectangulo
     
    mov x1, 220
    mov x2, 220
    mov x3, 200
    mov x4, 260
    movz x10, 0x3030, lsl 0      // Parte baja: G = 0x30, B = 0x30
    movk x10, 0xFF30, lsl 16     // Parte alta: A = 0xFF, R = 0x30
    bl rectangulo
    

     // --  Camino 
    mov x1, 320      // x_centro_arriba
    mov x2, 260      // y_arriba
    mov x3, 100      // ancho_arriba
    mov x4, 400      // ancho_abajo
    mov x5, 220      // altura
    movz x10, 0x8080, lsl 0
    movk x10, 0x0080, lsl 16
    bl trapezoide_centro


  // --- Dibujar líneas animadas ---
    //mov x21,260
    mov x25, x21                      // y actual = posición inicial
    mov x26, 0                        // contador de líneas

dibujar_lineas:
    // Dibujar una línea horizontal en y=x25
    mov x1, 0                         // x inicial (0 = borde izquierdo)
    mov x2, x25                       // y actual
    mov x3, SCREEN_WIDTH              // ancho (toda la pantalla)
    mov x4, x23                       // grosor
    movz x24, 0x8B22, lsl 0      // Parte baja: G = 8B (139), B = 22 (34)
    movk x24, 0xFF22, lsl 16     // Parte alta: A = FF (255), R = 22 (34)
    mov x10, x24                      // color
    bl rectangulo

    // Calcular siguiente posición y
    add x25, x25, x22                 // y += separación
    add x26, x26, 1                   // incrementar contador
    
    // Verificar si hemos pasado el fondo de la pantalla
    cmp x25, 480
    b.lt dibujar_lineas               // si no hemos llegado al fondo, dibujar más

    //Banquina izq
    mov x1, 190        // x inicial centrado
    mov x2, 220        // y inicial (igual que antes)
    mov x3, 25         // ancho de la patente
    mov x4, 260         // alto de la patente
    movz x10, 0x4040, lsl 0
    movk x10, 0xFF40, lsl 16
    bl rectangulo

    //Banquina der
    mov x1, 425        // x inicial centrado
    mov x2, 220        // y inicial (igual que antes)
    mov x3, 25         // ancho de la patente
    mov x4, 260         // alto de la patente
    movz x10, 0x4040, lsl 0
    movk x10, 0xFF40, lsl 16
    bl rectangulo

    //Ruta
    mov x1, 210
    mov x2, 220
    mov x3, 220
    mov x4, 260
    movz x10, 0x3030, lsl 0      // Parte baja: G = 0x30, B = 0x30
    movk x10, 0xFF30, lsl 16     // Parte alta: A = 0xFF, R = 0x30
    bl rectangulo
    
     //Linea horizonte
    mov x1, 1        // x inicial centrado
    mov x2, 217        // y inicial (igual que antes)
    mov x3, 640         // ancho de la patente
    mov x4, 3         // alto de la patente
    movz x24, 0x8B22, lsl 0      
    movk x24, 0xFF22, lsl 16 
    bl rectangulo

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

    
    

    // --- Pequeña pausa para controlar velocidad ---
    mov x27, 0x2700000   
                   // valor del delay (ajustar para velocidad)
delay_anim:
   
    subs x27, x27, 1

    b.ne delay_anim

    // --- Actualizar posición para siguiente frame ---
    add x21, x21, 5                  // mover las líneas hacia abajo (1 píxel por frame)
    
    // Verificar si hay que reiniciar la posición
    cmp x21, 260
    b.lt continuar_anim
    sub x21, x21, x22                        

continuar_anim:
    b animacion_loop                  // repetir infinitamente

InfLoop:
    b InfLoop                         // Bucle infinito final (por si acaso)

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



// ------------------- SUBRUTINA RECTANGULO -------------------
rectangulo:
    // x0 = framebuffer base
    // x1 = esquina superior izquierda x
    // x2 = esquina superior izquierda y
    // x3 = ancho
    // x4 = alto
    // w10 = color

    mov x5, 0                         // x5 = fila actual (Y dentro del rectángulo)
rect_filas:
    cmp x5, x4                        // ¿fila >= alto?
    b.ge fin_rect                     // Si sí, termina el rectángulo

    mov x6, 0                         // x6 = columna actual (X dentro del rectángulo)
rect_columnas:
    cmp x6, x3                        // ¿columna >= ancho?
    b.ge fin_rect_col                 // Si sí, termina la fila

    add x7, x2, x5                    // x7 = y real (y inicial + fila)
    mov x8, SCREEN_WIDTH
    mul x9, x7, x8                    // x9 = (y real) * SCREEN_WIDTH
    add x9, x9, x1                    // x9 = (y real) * SCREEN_WIDTH + x inicial
    add x9, x9, x6                    // x9 = ... + columna
    lsl x9, x9, 2                     // x9 = ... * 4 (bytes por píxel)
    add x11, x20, x9                  // x11 = dirección final del píxel

    stur w10, [x11]                   // Pinta el píxel con el color actual

    add x6, x6, 1                     // Siguiente columna
    b rect_columnas                   // Repite la fila
fin_rect_col:
    add x5, x5, 1                     // Siguiente fila
    b rect_filas                      // Repite el rectángulo
fin_rect:
    ret                               // Retorna al main



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

