
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
   
   
   mov x0, x20 
   bl patente
   bl nube
   
  

   



	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop




	
