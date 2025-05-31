.include "datos.s" 
.include "Graficos.s"
// .include "funciones.s"


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

   // bl pintar_cielo
 
 /*//dibujar el sol
    mov x2, SCREEN_WIDTH - 320 // Centro en x, x2
    mov x3, #170  // Centro en y, x3
    mov x4, #70 // Posicion inicial offset x4
    ldr w21, amarillo_anaranjado
    mov w1, w21 // Paso el color como parametro
    bl dibujar_circulo
*/
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
      
bl dibujar_auto

   
// Delay
    mov x27, 0x2700000
delay_loop:
    subs x27, x27, 1
    b.ne delay_loop

    b animacion_loop

   


