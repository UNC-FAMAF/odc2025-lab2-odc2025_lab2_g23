.ifndef datos_s
.equ datos_s, 0 

// en este archivo definimos las constantes. 

.equ SCREEN_WIDTH, 		640           // Ancho de la pantalla en píxeles
.equ SCREEN_HEIGH, 		480           // Alto de la pantalla en píxeles
.equ BITS_PER_PIXEL,  	32            // Bits por píxel (4 bytes)

.equ GPIO_BASE,      0x3f200000
.equ GPIO_GPFSEL0,   0x00
.equ GPIO_GPLEV0,    0x34

.equ cuadro_x_in, 150
.equ cuadro_x_fn, 490
.equ cuadro_y_in, 70
.equ cuadro_y_fn, 410

azul_1 : .word 0x005b6a
black : .word 0x000000

//Constantes del piso
.equ inicio_piso_x, 0
.equ inicio_piso_y, 260
.equ final_piso_x, 640
.equ final_piso_y, 480

//Colores
azul_claro: .word 0x175be4 
blanco: .word 0xffffff
gris: .word 0x606060
morado: .word 0x800080
morado_oscuro: .word 0x4b0082
amarillo: .word 0xffff00
gris_claro: .word 0xa0a0a0    
celeste: .word 0x8ecbff   
rojo : .word 0xe81515
amarillo_anaranjado : .word 0xe6c000
piso : .word 0xbb87f0
verde : .word 0x00994c
color_tronco : .word 0x007d91

.endif

