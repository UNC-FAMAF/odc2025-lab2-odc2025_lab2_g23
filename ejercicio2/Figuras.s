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


dibujar_patente:

    sub sp, sp, #16
    stur lr, [sp, #8]
    stur x2, [sp]
    //ldr w20, blanco
    //mov w1, w20
    
    // Dibujo O
    mov x2, #50
    mov x3, #50
    bl dibujar_O
   // add x2, x2, #10

    // Dibujo D
    
    mov x2, #70
    mov x3, #50
    bl dibujar_D
   //add x2, x2, #10

    // Dibujo C
    mov x2, #90
    mov x3, #50
    bl dibujar_C
    //add x2, x2, #10

    // Dibujo 2
    mov x2, #110
    mov x3, #50
    bl dibujar_2
    //add x2, x2, #10

    // Dibujo 0
    mov x2, #130
    mov x3, #50
    bl dibujar_O
    //add x2, x2, #10

    // Dibujo 2
    mov x2, #150
    mov x3, #50
    bl dibujar_2
    //add x2, x2, #10

    // Dibujo 5
    mov x2, #170
    mov x3, #50
    bl dibujar_5

    ldur x2, [sp]
    ldur lr, [sp, #8]
    add sp, sp, #16
    br lr


    loop: bl loop

.endif
