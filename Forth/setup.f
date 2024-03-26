


HEX

3F200000 CONSTANT GPFSEL0
3F200004 CONSTANT GPFSEL1
3F200008 CONSTANT GPFSEL2

3F20001C CONSTANT GPSET0
3F200028 CONSTANT GPCLR0

3F200034 CONSTANT GPLEV0

3F003004 CONSTANT SYSCLO
3F003008 CONSTANT SYSCHI
 

GPFSEL0 @ 00040000 OR GPFSEL0 !

GPFSEL1 @ 01000000 OR GPFSEL1 !

GPFSEL2 @ 08001240 OR GPFSEL2 !


: KEYROWOUT
	GPFSEL1 @ 00040040 OR GPFSEL1 !
	GPFSEL2 @ 00000009 OR GPFSEL2 !
	;


: KEYROWIN
	GPFSEL1 @ FFFBFF4F AND GPFSEL1 !
	GPFSEL2 @ FFFFFFF6 AND GPFSEL2 !
	;


: KEYCOLOUT
	GPFSEL1 @ 08000200 OR GPFSEL1 !
	GPFSEL2 @ 00048000 OR GPFSEL2 !
	;


: KEYCOLIN
	GPFSEL1 @ F7FFFDFF AND GPFSEL1 !
	GPFSEL2 @ FFFB7FFF AND GPFSEL2 !
	;


: LEDR 00040000 GPSET0 GPCLR0 ;
: LEDV 00800000 GPSET0 GPCLR0 ;
: LEDB 01000000 GPSET0 GPCLR0 ;
: LEDG 00400000 GPSET0 GPCLR0 ;
: LEDACT 20000000 GPSET0 GPCLR0 ;
: BUZZ 00000040 GPSET0 GPCLR0 ;


: MATRIXROWS 00311000 GPSET0 GPCLR0 ;
: MATRIXCOLS 06082000 GPSET0 GPCLR0 ;


: ON DROP ! ;
: OFF NIP ! ;

: ALLOFF LEDR OFF LEDV OFF LEDB OFF LEDG OFF BUZZ OFF ;


: ?PUSHED GPLEV0 @ 00020000 AND ; 


: ?DETECTED GPLEV0 @ 08000000 AND ;


: C1 GPLEV0 @ 00002000 AND IF 1 ELSE 0 THEN ;

: C2 GPLEV0 @ 00080000 AND IF 2 ELSE 0 THEN ;

: C3 GPLEV0 @ 04000000 AND IF 3 ELSE 0 THEN ;

: C4 GPLEV0 @ 02000000 AND IF 4 ELSE 0 THEN ;

: R1 GPLEV0 @ 00001000 AND IF 1 ELSE 0 THEN ;

: R2 GPLEV0 @ 00010000 AND IF 2 ELSE 0 THEN ;

: R3 GPLEV0 @ 00100000 AND IF 3 ELSE 0 THEN ; 

: R4 GPLEV0 @ 00200000 AND IF 4 ELSE 0 THEN ; 


: TIME SYSCLO @ ;


DECIMAL

: DELAY TIME + BEGIN DUP TIME - 0 <= UNTIL DROP ;

: MSEC 1000 * ;

: SEC MSEC 1000 * ;


