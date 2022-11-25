// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
(BEGIN)
	// Se establece el teclado en la direccion del valor de entrada para el teclado
	@24576
	D=A
	@keyboard
	M=D
(CHECK_KEYBOARD)
	// Se estable el mapa de pixeles actual a la ultima pantalla
	@24575
	D=A
	@current
	M=D
	// Si se presiona el teclado, llena la pantalla
	@keyboard
	A=M
	D=M
	@fillvalue
	M=-1
	@DRAW
	D;JNE
	// De lo contrario, se borra la pantalla 
	@fillvalue
	M=0
(DRAW)
	// Rellene o borre el pixel actual, segun el valor de relleno
	@fillvalue
	D=M
	@current
	A=M
	M=D
	// Si el mapa de pixeles actual es el primer mapa de pixeles, no queda nada por dibujar, por lo que
    //salta de nuevo a la verificacion del teclado.
	@current
	D=M
	@16384
	D=D-A
	@CHECK_KEYBOARD
	D;JLE
	// Decrementa el mapa de pixeles actuales
	@current
	M=M-1
	// Continua dibujando el siguiente mapa de pixeles
	@DRAW
	0;JMP