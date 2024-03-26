\ File che definisce le costanti e le WORD relative alle funzionalità di base
\ e all'interfacciamento con i registri

HEX

3F200000 CONSTANT GPFSEL0
3F200004 CONSTANT GPFSEL1
3F200008 CONSTANT GPFSEL2

3F20001C CONSTANT GPSET0
3F200028 CONSTANT GPCLR0

3F200034 CONSTANT GPLEV0

\ Registri che rappresentano i 64-bit del Clock di Sistema
\ Indicano il tempo (in microsecondi) trascorso dall'avvio del Sistema.
\ I 32MSB sono scritti nel registro SYSCHI, i 32LSB nel registro SYSCLO.
\ Nel corso del progetto verrà utilizzato solamente il registro SYSCLO

3F003004 CONSTANT SYSCLO
3F003008 CONSTANT SYSCHI

\ Imposto i GPIO 06, 18, 23 e 24 come Output 
\ lasciando invariate le GPIO Function degli altri GPIO
 

GPFSEL0 @ 00040000 OR GPFSEL0 !

GPFSEL1 @ 01000000 OR GPFSEL1 !

GPFSEL2 @ 08001240 OR GPFSEL2 !

\ Word per impostare velocemente tutte le righe della Button Matrix come output

: KEYROWOUT
	GPFSEL1 @ 00040040 OR GPFSEL1 !
	GPFSEL2 @ 00000009 OR GPFSEL2 !
	;

\ Word per impostare velocemente tutte le righe della Button Matrix come input

: KEYROWIN
	GPFSEL1 @ FFFBFF4F AND GPFSEL1 !
	GPFSEL2 @ FFFFFFF6 AND GPFSEL2 !
	;

\ Word per impostare velocemente tutte le colonne della Button Matrix come output

: KEYCOLOUT
	GPFSEL1 @ 08000200 OR GPFSEL1 !
	GPFSEL2 @ 00048000 OR GPFSEL2 !
	;

\ Word per impostare velocemente tutte le colonne della Button Matrix come input

: KEYCOLIN
	GPFSEL1 @ F7FFFDFF AND GPFSEL1 !
	GPFSEL2 @ FFFB7FFF AND GPFSEL2 !
	;


\ Words per inserire nello Stack gli elementi utili a impostare il livello
\ del GPIO corrispondente a un certo componente del sistema

: LEDR 00040000 GPSET0 GPCLR0 ;
: LEDV 00800000 GPSET0 GPCLR0 ;
: LEDB 01000000 GPSET0 GPCLR0 ;
: LEDG 00400000 GPSET0 GPCLR0 ;
: LEDACT 20000000 GPSET0 GPCLR0 ;
: BUZZ 00000040 GPSET0 GPCLR0 ;

\ Words per inserire nello Stack gli elementi utili a impostare il livello
\ di tutti i GPIO di righe o colonne della Button Matrix

: MATRIXROWS 00311000 GPSET0 GPCLR0 ;
: MATRIXCOLS 06082000 GPSET0 GPCLR0 ;


\ Words che, data la rappresentazione esadecimale di uno o più GPIO
\ e i registri GPSET0 e GPCLR0, impostano gli stati HIGH o LOW.

: ON DROP ! ;
: OFF NIP ! ;


\ Word che forza il livello LOW su tutte le componenti di output del Sistema

: ALLOFF LEDR OFF LEDV OFF LEDB OFF LEDG OFF BUZZ OFF ;


\ Word che verifica se il GPIO17 (Button) è High.
\ Restituisce un flag.

: ?PUSHED GPLEV0 @ 00020000 AND ; 

\ Word che verifica se il GPIO27 (PIR Sensor) è HIGH
\ Restituisce un flag.

: ?DETECTED GPLEV0 @ 08000000 AND ;

\ Words per rilevare la pressione di un tasto appartenente a una certa colonna
\ della Button Matrix.
\ Restituiscono il valore della colonna corrispondente.

: C1 GPLEV0 @ 00002000 AND IF 1 ELSE 0 THEN ;

: C2 GPLEV0 @ 00080000 AND IF 2 ELSE 0 THEN ;

: C3 GPLEV0 @ 04000000 AND IF 3 ELSE 0 THEN ;

: C4 GPLEV0 @ 02000000 AND IF 4 ELSE 0 THEN ;


\ Words per rilevare la pressione di un tasto appartenente a una certa riga
\ della Button Matrix.
\ Restituiscono il valore della riga corrispondente.

: R1 GPLEV0 @ 00001000 AND IF 1 ELSE 0 THEN ;

: R2 GPLEV0 @ 00010000 AND IF 2 ELSE 0 THEN ;

: R3 GPLEV0 @ 00100000 AND IF 3 ELSE 0 THEN ; 

: R4 GPLEV0 @ 00200000 AND IF 4 ELSE 0 THEN ; 


\ Word per fare Fetch del contenuto del registro SYSCLO, determinando il
\ Tempo trascorso dall'avvio del sistema

: TIME SYSCLO @ ;


DECIMAL

\ Word per la creazione di un Busy Loop dato un periodo di tempo espresso in microsecondi.

: DELAY TIME + BEGIN DUP TIME - 0 <= UNTIL DROP ;


\ Word di conversione dell'unità di tempo

: MSEC 1000 * ;

: SEC MSEC 1000 * ;


