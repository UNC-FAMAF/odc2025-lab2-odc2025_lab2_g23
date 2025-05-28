.ifndef figuras_s
.equ figuras_s, 0

.include "datos.s"
.include "Graficos.s"

nube:
    //Registros que guardan datos de la nube
    mov x19, SCREEN_WIDTH - 150
    mov x21, 200
    mov x18, 20
    ldr w1, blanco
    bl dibujar_nube

    mov x19, SCREEN_WIDTH - 180
    mov x21, 210
    mov x18, 20
    ldr w1, blanco
    bl dibujar_nube
    
    mov x19, SCREEN_WIDTH - 400
    mov x21, 160
    mov x18, 20
    ldr w1, blanco
    bl dibujar_nube
    

    mov x19, SCREEN_WIDTH - 430
    mov x21, 150
    mov x18, 20
    ldr w1, blanco
    bl dibujar_nube


    mov x19, SCREEN_WIDTH - 640
    mov x21, 300
    mov x18, 20
    ldr w1, blanco
    bl dibujar_nube

    mov x19, SCREEN_WIDTH - 600
    mov x21, 100
    mov x18, 20
    ldr w1, blanco
    bl dibujar_nube

    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 
    br lr

patente:
    sub sp, sp, #8
    stur lr, [sp]

    ldr w1, black

    
    bl pintar_por_pixel


    // Coordenadas base (cerca del centro de la pantalla)
    mov x2, SCREEN_WIDTH
    sub x2, x2, #200     // x inicial
    mov x3, #300         // y inicial

    // Tamaño de letra
    mov x10, #20         // ancho
    mov x11, #40         // alto
    mov x12, #10         // espaciado entre letras

    // ---------------- LETRA O ----------------
    mov x4, x2
    add x5, x2, x10
    mov x6, x3
    add x7, x3, x11

    // Horizontal arriba
    mov x2, x4
    mov x3, x6
    mov x4, x5
    bl linea_horizontal

    // Horizontal abajo
    mov x3, x7
    bl linea_horizontal

    // Vertical izquierda
    mov x2, x4
    mov x3, x6
    mov x4, x7
    bl linea_vertical

    // Vertical derecha
    mov x2, x5
    bl linea_vertical

    // ---------------- LETRA D ----------------
    add x2, x5, x12
    add x5, x2, x10

    // Vertical izquierda
    mov x3, x6
    mov x4, x7
    bl linea_vertical

    // Horizontal arriba
    mov x2, x2
    mov x3, x6
    mov x4, x5
    bl linea_horizontal

    // Horizontal abajo
    mov x3, x7
    bl linea_horizontal

    // Vertical curva derecha (simulada)
    mov x2, x5
    mov x3, x6
    add x4, x6, #10
    bl linea_vertical
    add x3, x6, #30
    add x4, x6, #40
    bl linea_vertical

    // ---------------- LETRA C ----------------
    add x2, x5, x12
    add x5, x2, x10

    // Horizontal arriba
    mov x3, x6
    bl linea_horizontal

    // Horizontal abajo
    mov x3, x7
    bl linea_horizontal

    // Vertical izquierda
    mov x2, x2
    mov x3, x6
    mov x4, x7
    bl linea_vertical

    // ---------------- LETRA 2 ----------------
    add x2, x5, x12
    add x5, x2, x10

    // Horizontal arriba
    mov x3, x6
    bl linea_horizontal

    // Curva derecha arriba
    mov x2, x5
    mov x3, x6
    add x4, x6, #10
    bl linea_vertical

    // Línea media
    mov x2, x2
    mov x3, x6
    add x3, x3, #20
    mov x4, x5
    bl linea_horizontal

    // Diagonal hacia abajo izquierda (simulada)
    mov x2, x2
    mov x3, x6
    add x3, x3, #20
    mov x4, x7
    bl linea_vertical

    // ---------------- LETRA 5 ----------------
    add x2, x5, x12
    add x5, x2, x10

    // Horizontal arriba
    mov x3, x6
    bl linea_horizontal

    // Vertical izquierda arriba
    mov x2, x2
    mov x3, x6
    add x4, x6, #20
    bl linea_vertical

    // Línea media
    mov x3, x6
    add x3, x3, #20
    mov x4, x5
    bl linea_horizontal

    // Vertical derecha abajo
    mov x2, x5
    mov x3, x6
    add x3, x3, #20
    mov x4, x7
    bl linea_vertical

    // Línea abajo
    mov x2, x2
    mov x3, x7
    mov x4, x5
    bl linea_horizontal

    // ---------------- FIN ----------------
    ldur lr, [sp]
    add sp, sp, #8
    br lr





    loop: bl loop

.endif
