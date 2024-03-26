\\\\\\\
\ File che si occupa della gestione della Password di Sistema.

\ Ridimensiono la lunghezza di una cella

DECIMAL

: CELLS 32 * ;
: CELLS+ CELLS + ;


\ Array che memorizza le 3 cifre della Password di Sistema impostata

VARIABLE PSW 2 CELLS ALLOT
DROP

\ Array che memorizza le 3 cifre temporanee della Password che si sta digitando

VARIABLE TMP 2 CELLS ALLOT
DROP

HEX

: SETSOUND
	DECIMAL
	BUZZ ON
	50 MSEC DELAY
	BUZZ OFF
	50 MSEC DELAY
	BUZZ ON
	50 MSEC DELAY
	BUZZ OFF
	HEX
	;


\ Word che consente di impostare la Password di 3 cifre da utilizzare per accedere al Sistema.
\ Ogni tasto deve essere premuto per meno di 350 MSEC per evitare che venga registrato nuovamente
\ come pressione del tasto successivo.

: SETPSW
	DECIMAL
	LEDACT ON

	READBUTTON
	PSW !
	BUZZ ON 
	DECIMAL
	75 MSEC DELAY
	HEX
	BUZZ OFF
	500 MSEC DELAY

	READBUTTON
	PSW 1 CELLS+ !
	BUZZ ON 
	DECIMAL
	75 MSEC DELAY
	HEX
	BUZZ OFF
	500 MSEC DELAY

	READBUTTON
	PSW 2 CELLS+ !
	BUZZ ON 
	DECIMAL
	75 MSEC DELAY
	HEX
	BUZZ OFF

	SETSOUND
	LEDACT OFF
	HEX
	;


: WRITEPSW
	DECIMAL
	READBUTTON
	TMP !
	500 MSEC DELAY

	READBUTTON
	TMP 1 CELLS+ !
	500 MSEC DELAY

	READBUTTON
	TMP 2 CELLS+ !
	500 MSEC DELAY

	SETSOUND
	HEX
	;

\ Word che confronta il contenuto degli array PSW e TMP verificando la corrispondenza
\ tra la Password inserita e quella registrata nel Sistema.
\ Restituisce un flag non-zero in caso di corrispondenza, viceversa restituirà '0'.

: ?CHECKPSW
	PSW @
	TMP @
	- 0= IF
		1
	ELSE
		0
	THEN

	PSW 1 CELLS+ @
	TMP 1 CELLS+ @
	- 0= IF
		1
	ELSE
		0
	THEN

	PSW 2 CELLS+ @
	TMP 2 CELLS+ @
	- 0= IF
		1
	ELSE
		0
	THEN
	
	AND AND
	;








