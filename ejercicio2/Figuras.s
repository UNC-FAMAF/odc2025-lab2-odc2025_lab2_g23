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

dibujar_O:
    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x2, [sp]
    

 
    add x2, x2, #4     // centro x
    add x3, x3, #5     // centro y      
    bl dibujar_circulo

    ldur x2, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr

 
dibujar_D:

    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x2, [sp]

    // Línea vertical izquierda
    mov x4, x3
    add x5, x3, #9
    bl linea_vertical

    // Línea horizontal arriba
    mov x3, x3
    add x4, x2, #5
    bl linea_horizontal

    // Línea horizontal abajo
    add x3, x3, #9
    mov x4, x2
    add x4, x4, #5
    bl linea_horizontal

    // Línea vertical derecha (más corta)
    sub x3, x3, #9
    add x2, x2, #5
    add x4, x3, #9
    bl linea_vertical

    ldur x2, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr

dibujar_C:
    sub sp, sp , #32
    stur lr, [sp, #24]
    stur x2, [sp, #16]
    stur x3, [sp, #8]

    // Línea superior
    mov x4, x2
    add x4, x4, #6
    ldr w1, blanco
    bl linea_horizontal

    // Línea izquierda
    ldur x2, [sp, #16]
    ldur x3, [sp, #8]
    mov x4, x3
    add x5, x3, #9
    ldr w1, blanco
    bl linea_vertical

    // Línea inferior
    ldur x2, [sp, #16]
    ldur x3, [sp, #8]
    add x3, x3, #9
    mov x4, x2
    add x4, x4, #6
    ldr w1, blanco
    bl linea_horizontal

    ldur x2, [sp, #16]
    ldur x3, [sp, #8]
    ldur lr, [sp, #24]
    add sp, sp, #32
    br lr
dibujar_2:

    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x2, [sp]

    // Línea superior
    mov x4, x2
    add x4, x4, #6
    bl linea_horizontal

    // Línea diagonal descendente derecha
    add x2, x2, #6
    add x3, x3, #1
    mov x5, x3
    add x5, x5, #3
loop_diag_2:
    cmp x3, x5
    b.gt fin_diag_2
    bl pintar_por_pixel
    add x2, x2, #-1
    add x3, x3, #1
    b loop_diag_2
fin_diag_2:

    // Línea horizontal media
    mov x4, x2
    add x4, x4, #6
    bl linea_horizontal

    // Línea vertical derecha
    add x2, x2, #6
    add x3, x3, #1
    mov x4, x3
    add x5, x3, #3
    bl linea_vertical

    // Línea inferior
    add x3, x3, #3
    mov x4, x2
    sub x4, x4, #6
    bl linea_horizontal

    ldur x2, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr
dibujar_5:
    

    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x2, [sp]

    // Línea superior
    mov x4, x2
    add x4, x4, #6
    bl linea_horizontal

    // Línea vertical izquierda superior
    mov x4, x3
    add x5, x3, #4
    bl linea_vertical

    // Línea media
    add x3, x3, #4
    mov x4, x2
    add x4, x4, #6
    bl linea_horizontal

    // Línea vertical derecha inferior
    add x2, x2, #6
    add x3, x3, #1
    mov x4, x3
    add x5, x3, #4
    bl linea_vertical

    // Línea inferior
    add x3, x3, #4
    mov x4, x2
    sub x4, x4, #6
    bl linea_horizontal

    ldur x2, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr



dibujar_patente:

    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x2, [sp]
    //ldr w20, blanco
    //mov w1, w20
    // Dibujo O

    bl dibujar_O
    add x2, x2, #10

    // Dibujo D
    bl dibujar_D
    add x2, x2, #10

    // Dibujo C
    bl dibujar_C
    add x2, x2, #10

    // Dibujo 2
    bl dibujar_2
    add x2, x2, #10

    // Dibujo 0
    bl dibujar_O
    add x2, x2, #10

    // Dibujo 2
    bl dibujar_2
    add x2, x2, #10

    // Dibujo 5
    bl dibujar_5

    ldur x2, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr


    loop: bl loop

.endif
