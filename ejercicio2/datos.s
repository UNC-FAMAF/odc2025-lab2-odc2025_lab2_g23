.ifndef datos_s
.equ datos_s, 0 

//En este archivo definimos constantes que utilizamos en todas las funciones de los demas archivos.

//DELAY

//DELAY : .word 0x5FF5E100
//DELAY2 : .word 0x175F0000

//Pantalla

.equ SCREEN_WIDTH,   640
.equ SCREEN_HEIGH,  480
.equ BITS_PER_PIXEL, 32
.equ cuadro_x_in, 150
.equ cuadro_x_fn, 490
.equ cuadro_y_in, 70
.equ cuadro_y_fn, 410

//
azul_1 : .word 0x005b6a
//azul_2 : .word 0x00306a
//azul_3 : .word 0x000046
//negro : .word 0x000000

    //sol anaranjado
//color_sol : .word 0xe6c000


	//edificio
//color_edificio : .word 0x96c846
//.equ emp_edificio_x, 400
//.equ emp_edificio_y, 350
//.equ fin_edicifio_x, 455
//.equ fin_edicifio_y, 360


/*/Constantes del auto

.equ inicio_auto_x, 240
.equ final_auto_x, 400
.equ inicio_auto_y, 250 
.equ final_auto_y, 330

.equ inicio_techo_auto_x, 280 
.equ final_techo_auto_x, 360 
.equ inicio_techo_auto_y, 180 
.equ final_techo_auto_y,  250 

.equ primera_rueda_x, 260 
.equ primera_rueda_y, 330
.equ segunda_rueda_x, 380 
.equ segunda_rueda_y, 330
.equ radio_ruedas, 30

//Constantes de la calle
    
    //Calle
    .equ inicio_calle_x, 0
    .equ inicio_calle_y, 120
    .equ final_calle_x, 640
    .equ final_calle_y, 360 
    
    //Lineas de la calle
    //Primer linea
    .equ inicio_pr_linea_x, 0
    .equ inicio_pr_linea_y, 238 
    .equ final_pr_linea_x, 640
    .equ final_pr_linea_y, 242
    //Segunda linea
    .equ inicio_sg_linea_x, 0
    .equ inicio_sg_linea_y, 118
    .equ final_sg_linea_x, 640
    .equ final_sg_linea_y, 122
    //Tercera Linea
    .equ inicio_tr_linea_x, 0
    .equ inicio_tr_linea_y, 358
    .equ final_tr_linea_x, 640
    .equ final_tr_linea_y, 362
*/
//Constantes del piso
.equ inicio_piso_x, 0
.equ inicio_piso_y, 360
.equ final_piso_x, 640
.equ final_piso_y, 480

//Colores
//azul_claro: .word 0x175be4 
//blanco: .word 0xddffdd
//gris: .word 0x606060
//amarillo: .word 0xffff00
//gris_claro: .word 0xa0a0a0    
celeste: .word 0x8ecbff   
//rojo : .word 0xe81515
amarillo_anaranjado : .word 0xe6c000
//piso : .word 0xbb87f0
verde : .word 0x00994c
//color_tronco : .word 0x007d91

.endif
