\ File che definisce le costanti e le WORD relative al controllo delle componenti hardware

HEX

\ Word che definisce il funzionamento intermittente dei LED e del Buzzer
\ nello stato di allarme.

: ALARMBLINK
	DECIMAL
	LEDR ON BUZZ ON
	150 MSEC DELAY 
	LEDR OFF BUZZ OFF
	100 MSEC DELAY 
	LEDB ON BUZZ ON
	150 MSEC DELAY 
	LEDB OFF BUZZ OFF
	100 MSEC DELAY
	HEX
	;

\ Words per semplificare il setup dei differenti stati del sistema

: IDLESETUP ALLOFF LEDG ON ;

: ALERTSETUP ALLOFF DECIMAL 2 SEC DELAY HEX LEDV ON ;

: ALARMSETUP ALLOFF ;

\ Word che verifica se vi è una pressione del pulsante bianco pari a 3 secondi.
\ Si tratta in realtà di un trick per simulare ciò, in realtà il sistema verifica
\ se, dopo la pressione del pulsante, questo viene premuto nuovamente dopo
\ esattamente 3 Secondi.
\ Questa cosa consente di simulare la pressione prolungata e, trattandosi di
\ una funzionalità che non necessità di misure di sicurezza, non comporta
\ alcuna problematica durante l'utilizzo del sistema.

: ?3SECPUSH
	0 BEGIN 
	?PUSHED IF 
		DECIMAL
		3 SEC DELAY 
		HEX 
		?PUSHED 
	ELSE 
		0 
	THEN 
		OR 
		DUP 
	UNTIL DROP FFFFFFFF
	;


\\\\\ WORDS FUNZIONAMENTO PUSH BUTTON MATRIX


\ Words che generano un Loop finché un tasto non viene premuto

\ WAITPRESCOL registrerà la colonna a cui appartiene il tasto premuto

: WAITPRESSCOL
	0 BEGIN DROP C1 C2 C3 C4 OR OR OR DUP UNTIL ;

\ WAITPRESSROW registrerà la riga a cui appartiene il tasto premuto

: WAITPRESSROW
	0 BEGIN DROP R1 R2 R3 R4 OR OR OR DUP UNTIL ;

\ Word che legge il valore della riga a cui appartiene il pulsante premuto

: READCOL
	KEYROWOUT
	KEYCOLIN
	MATRIXROWS ON
	WAITPRESSCOL
	MATRIXROWS OFF
	;

\ Word che legge il valore della riga a cui appartiene il pulsante premuto

: READROW
	KEYCOLOUT
	KEYROWIN
	MATRIXCOLS ON
	WAITPRESSROW
	MATRIXCOLS OFF
	;

\ Valore associato a ogni pulsante della Button Matrix

: B1 1 ;

: B2 2 ;

: B3 3 ;

: B4 A ;

: B5 4 ;

: B6 5 ;

: B7 6 ;

: B8 B ;

: B9 7 ;

: B10 8 ;

: B11 9 ;

: B12 C ;

: B13 F ;

: B14 0 ;

: B15 E ;

: B16 D ;

\ Words che, dati i valori di colonna e riga corrispondenti al pulsante premuto,
\ restituiscono il valore del pulsante corrispondente.

: ?B1 2DUP 1 - SWAP 1 - OR 0= IF 2DROP B1 THEN ;

: ?B2 2DUP 1 - SWAP 2 - OR 0= IF 2DROP B2 THEN ;

: ?B3 2DUP 1 - SWAP 3 - OR 0= IF 2DROP B3 THEN ;

: ?B4 2DUP 1 - SWAP 4 - OR 0= IF 2DROP B4 THEN ;

: ?B5 2DUP 2 - SWAP 1 - OR 0= IF 2DROP B5 THEN ;

: ?B6 2DUP 2 - SWAP 2 - OR 0= IF 2DROP B6 THEN ;

: ?B7 2DUP 2 - SWAP 3 - OR 0= IF 2DROP B7 THEN ;

: ?B8 2DUP 2 - SWAP 4 - OR 0= IF 2DROP B8 THEN ;

: ?B9 2DUP 3 - SWAP 1 - OR 0= IF 2DROP B9 THEN ;

: ?B10 2DUP 3 - SWAP 2 - OR 0= IF 2DROP B10 THEN ;

: ?B11 2DUP 3 - SWAP 3 - OR 0= IF 2DROP B11 THEN ;

: ?B12 2DUP 3 - SWAP 4 - OR 0= IF 2DROP B12 THEN ;

: ?B13 2DUP 4 - SWAP 1 - OR 0= IF 2DROP B13 THEN ;

: ?B14 2DUP 4 - SWAP 2 - OR 0= IF 2DROP B14 THEN ;

: ?B15 2DUP 4 - SWAP 3 - OR 0= IF 2DROP B15 THEN ;

: ?B16 2DUP 4 - SWAP 4 - OR 0= IF 2DROP B16 THEN ;

\ Word che inserisce nello Stack il valore del pulsante premuto

: BTNVALUE ?B1 ?B2 ?B3 ?B4 ?B5 ?B6 ?B7 ?B8 ?B9 ?B10 ?B11 ?B12 ?B13 ?B14 ?B15 ?B16 ;


\ La WORD START non fa altro che avviare la procedura di lettura di un singolo
\ pulsante, inserendone il corrispondente valore nello stack

: READBUTTON
	READCOL
	READROW
	BTNVALUE
;



