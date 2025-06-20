.include "datos.s" 
.include "Graficos.s"
.include "funciones.s"

.globl main
.equ DELAY_ANIMACION, 0x2700000 //Delay modificable para animación de pasto

.globl main
main:
    mov x20, x0       // dirección framebuffer
    
    bl pintar_cielo
    //dibujar el sol
    mov x2, SCREEN_WIDTH - 320 // Centro en x, x2
    mov x3, #150  // Centro en y, x3
    mov x4, #60 // Posicion inicial offset x4
    ldr w15, amarillo_anaranjado
    mov w1, w15 // Paso el color como parametro
    bl dibujar_circulo

    mov x2, 100
    mov x3, 100
    mov x4, 20
    bl dibujar_nube


    mov x2, 500
    mov x3, 100
    mov x4, 20
    bl dibujar_nube

    mov x2, 250 
    mov x3, 150 
    mov x4, 20
    bl dibujar_nube

    

    mov x2, SCREEN_WIDTH - 320 // Centro en x, x2
    mov x3, #150  // Centro en y, x3
    mov x4, #40 // Posicion inicial offset x4
    ldr w15, amarillo
    mov w1, w15 // Paso el color como parametro
    bl dibujar_circulo
    
    // Configuración inicial
    mov x21, 250      // offset líneas horizontales
    mov x15, 240      // offset cuadrados
    mov x22, 50       // separación entre cuadrados
    mov x23, 10       // lado del cuadrado
    movz x25, 0xFFFF, lsl 0
    movk x25, 0x00FF, lsl 16  // blanco


 
animacion_loop:
    // --- Borrar cuadrados anteriores ---
    // Recorre todas las posiciones donde hay cuadrados y los "borra"
    // pintando encima con el color del fondo de la ruta.
    mov x26, 0
    mov x27, x21
borrar_loop:
    mov x0, x20                      //Framebuffer base
    mov x1, 320 - 5                  // Posición x fija de los cuadrados
    mov x2, x27                     // Posición y de los cuadrados             
    mov x9, x23                     // Lado del cuadrado                                 
    movz x10, 0x3030, lsl 0         // gris ruta
    movk x10, 0xFF30, lsl 16
    bl cuadrado                     // Dibuja el cuadrado "borrador"

    add x27, x27, x22       // Incrementa la posición y para el siguiente cuadrado
    cmp x27, 480            // Compara si se ha llegado al final de la pantalla
    b.lt borrar_loop        // Si no, repite el bucle

   
    // --- Redibujar fondo y elementos estáticos ---
    // Se dibuja el fondo, banquinas, ruta, columnas, cartel, etc.
    // Esto asegura que la escena se repinta en cada frame.
 
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
    //bl dibujar_ruta  
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
    
    bl palabra 

// --- Dibujar líneas verdes horizontales ---
    // Se dibujan varias líneas verdes horizontales para el efecto visual.
    // Se usa un bucle para posicionarlas con separación fija.
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

    // --- Dibujar nuevos cuadrados en sus posiciones actualizadas ---
    // Se dibujan los cuadrados en sus nuevas posiciones para la animación.
    mov x26, 0
    mov x27, x21
cuadrado_loop:
    mov x0, x20
    mov x1, 320 - 5
    mov x2, x27
    mov x9, x23
    mov x10, x25       //Color blanco
    bl cuadrado
    
    add x27, x27, x22
    cmp x27, 480
    b.lt cuadrado_loop



bl dibujar_auto


 // --- Actualizar posiciones para la próxima iteración ---
    // Se incrementan los offsets para las líneas y los cuadrados,
    // creando el efecto de movimiento.
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

    // --- Delay para controlar la velocidad de la animación ---
    // Este bucle vacío introduce una pausa para que la animación sea visible.
    mov x27, DELAY_ANIMACION
delay_loop:
    subs x27, x27, 1
    b.ne delay_loop
  // --- Volver al inicio del bucle para el siguiente frame ---
    b animacion_loop




   


   


