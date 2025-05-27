/*
.global escena
.global linea_verde_animada
.global animar_linea
.global Cesped
.global edificios
.global camino
.global auto
edificios:
    // Edificio 1
    mov x1, 50          // x inicial
    mov x2, 140         // y inicial
    mov x3, 40          // ancho
    mov x4, 120         // alto
    movz w10, 0x4040, lsl 0
    movk w10, 0x0040, lsl 16
    bl rectangulo

    // Edificio 2
    mov x1, 120
    mov x2, 140
    mov x3, 60
    mov x4, 120
    movz w10, 0x8080, lsl 0
    movk w10, 0x0080, lsl 16
    bl rectangulo

    // Edificio 3
    mov x1, 200
    mov x2, 140
    mov x3, 80
    mov x4, 120
    movz w10, 0xC0C0, lsl 0
    movk w10, 0x00C0, lsl 16
    bl rectangulo

    ret

Cesped:
    // --- Pasto ---
    mov x1, 1                       // x inicial del rectángulo
    mov x2, 260                        // y inicial del rectángulo
    mov x3, 640                      // ancho del rectángulo
    mov x4, 220                        // alto del rectángulo
    movz w10, 0xC040, lsl 0          // Carga parte baja del color verde en w10
    movk w10, 0x0042, lsl 16         // Completa el color verde en w10
    bl rectangulo                    // Llama a la subrutina rectángulo

    ret

camino:
     // --  Camino 
    mov x1, 320      // x_centro_arriba
    mov x2, 260      // y_arriba
    mov x3, 100      // ancho_arriba
    mov x4, 400      // ancho_abajo
    mov x5, 220      // altura
    movz w10, 0x8080, lsl 0
    movk w10, 0x0080, lsl 16
    bl trapezoide_centro

     // --  linea 
    mov x1, 320      // x_centro_arriba (igual que el camino)
    mov x2, 260      // y_arriba (igual que el camino)
    mov x3, 12      // ancho_arriba (proporcional: 100/5)
    mov x4, 24       // ancho_abajo (proporcional: 400/5)
    mov x5, 20       // altura (proporcional: 220/5)
    movz w10, 0xFFFF, lsl 0   // blanco
    movk w10, 0x00FF, lsl 16
    bl trapezoide_centro

     // --  linea 2
    mov x1, 320      // x_centro_arriba (igual que el camino)
    mov x2, 300      // y_arriba (igual que el camino)
    mov x3, 16      // ancho_arriba (proporcional: 100/5)
    mov x4, 24       // ancho_abajo (proporcional: 400/5)
    mov x5, 20       // altura (proporcional: 220/5)
    movz w10, 0xFFFF, lsl 0   // blanco
    movk w10, 0x00FF, lsl 16
    bl trapezoide_centro

    // -- Linea 3
    mov x1, 320      // x_centro_arriba (igual que el camino)
    mov x2, 420      // y_arriba (igual que el camino)
    mov x3, 20      // ancho_arriba (proporcional: 100/5)
    mov x4, 33       // ancho_abajo (proporcional: 400/5)
    mov x5, 30       // altura (proporcional: 220/5)
    movz w10, 0xFFFF, lsl 0   // blanco
    movk w10, 0x00FF, lsl 16
    bl trapezoide_centro
   ret
auto:  
    // --- Carrocería principal ---
    mov x1, 220         // x inicial
    mov x2, 350         // y inicial
    mov x3, 200         // ancho
    mov x4, 60          // alto
    movz w10, 0x00A0, lsl 0
    movk w10, 0x0070, lsl 16
    bl rectangulo

    // --- Vidrio trasero ---
    mov x1, 250
    mov x2, 320
    mov x3, 140
    mov x4, 30
    movz w10, 0xE0FF, lsl 0
    movk w10, 0x00A0, lsl 16
    bl rectangulo

    // --- Luces traseras (izquierda) ---
    mov x1, 230
    mov x2, 390
    mov x3, 30
    mov x4, 15
    movz w10, 0x4080, lsl 0
    movk w10, 0x00FF, lsl 16
    bl rectangulo

    // --- Luces traseras (derecha) ---
    mov x1, 380
    mov x2, 390
    mov x3, 30
    mov x4, 15
    movz w10, 0x4080, lsl 0
    movk w10, 0x00FF, lsl 16
    bl rectangulo

    // --- Patente (blanco) centrada ---
    mov x1, 300        // x inicial centrado
    mov x2, 385        // y inicial (igual que antes)
    mov x3, 40         // ancho de la patente
    mov x4, 20         // alto de la patente
    movz w10, 0xFFFF, lsl 0
    movk w10, 0x00FF, lsl 16
    bl rectangulo

    //Linea que cruza la carroceria 
    mov x1, 220        // x inicial centrado
    mov x2, 370        // y inicial (igual que antes)
    mov x3, 200         // ancho de la patente
    mov x4, 5         // alto de la patente
    movz w10, 0xFFFF, lsl 0
    movk w10, 0x00FF, lsl 16
    bl rectangulo

    // --- Rueda izquierda ---
    mov x1, 225
    mov x2, 410
    mov x3, 30
    mov x4, 10
    movz w10, 0x0000, lsl 0
    movk w10, 0x0000, lsl 16
    bl rectangulo

    // --- Rueda derecha ---
    mov x1, 385
    mov x2, 410
    mov x3, 30
    mov x4, 10
    movz w10, 0x0000, lsl 0
    movk w10, 0x0000, lsl 16
    bl rectangulo

    //-- Triangulo izquierdo 
    mov x1, 390    // x inicial
    mov x2, 320      // y inicial
    mov x3, 30       // base/altura
    movz w10, 0xFFFF, lsl 0
    movk w10, 0x00FF, lsl 16
    bl triangulo_izq

    // -- Triangulo derecho
    mov x1, 220     // x inicial 
    mov x2, 320      // y inicial 
    mov x3, 30       // base/altura
    movz w10, 0xFFFF, lsl 0
    movk w10, 0x00FF, lsl 16
    bl triangulo_der


    ret
 */