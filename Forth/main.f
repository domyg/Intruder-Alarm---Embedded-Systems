\ File contenente il corpo del programma che, utilizzando le Word di alto livello 
\ definite nei vari files, determina il comportamento del Sistema.
\ Sono definite, inoltre, delle WORD per la definizione e il cambiamento di stato del sistema.


: IDLELOOP
	BEGIN 
		IDLESETUP
		?3SECPUSH IF
			ALLOFF
			LEDR ON
			READBUTTON
			DUP
			B16 - 0= IF
				DROP
				LEDR OFF
				BEGIN
					LEDG ON
					BUZZ ON
					DECIMAL
					350 MSEC DELAY
					HEX
					BUZZ OFF
					LEDG OFF
					LEDV ON
					WRITEPSW
					.s
					?CHECKPSW
				UNTIL
				LEDV OFF
				DECIMAL
				250 MSEC DELAY
				HEX
				LEDR ON
				LEDB ON
				SETPSW
				LEDR OFF
				LEDB OFF
				0
			ELSE
				B13 - 0= IF
					1
				ELSE 0
				THEN
			THEN	
		ELSE 0
		THEN
	UNTIL 
	;

: SENSORLOOP 
	BEGIN 
	?PUSHED IF 
		ALLOFF 
		DECIMAL
		1 SEC DELAY 
		HEX
		IDLELOOP ALERTSETUP 0 
	ELSE ?DETECTED 
	THEN UNTIL ;

: ALARMLOOP 
	BEGIN 
		ALARMBLINK 
	?PUSHED UNTIL 
	;

: SECURITYLOOP 
	BEGIN
		BUZZ ON
		LEDR ON
		WRITEPSW
		.s
		?CHECKPSW IF
			1
			BUZZ OFF
			LEDR OFF
		ELSE
			0
		THEN
	UNTIL
	;

: START
	
	\ Start State
	
	LEDR ON
	LEDB ON
	SETPSW
	LEDR OFF
	LEDB OFF
	.s
	BEGIN 0	

	\ Idle State

	IDLELOOP

	\ Alert State

	ALERTSETUP
	SENSORLOOP

	\ Alarm State

	ALARMSETUP
	ALARMLOOP
	
	\ Security State

	SECURITYLOOP
	UNTIL
	;

START


