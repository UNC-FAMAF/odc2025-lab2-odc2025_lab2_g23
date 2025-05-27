
	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34
	.include "datos.s"
	.include "Graficos.s"
	.include "Figuras.s"
	//.include "funciones.s"
	.globl main

main:
	// x0 contiene la direccion base del framebuffer
    mov x20, x0	// Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

   bl pintar_fondo

   bl dibujar_ruta
   
   bl nube

  mov x2, #50
  mov x3, #20
  bl dibujar_C



	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop




	
