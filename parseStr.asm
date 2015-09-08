; int parseStr(char* src, char** p_dest);
;
; Funktion gibt die Summe der Zahlen im String zurück
; und erstellt neuen String ohne enthaltende Zahlen. 
; Pointer auf neuen String über p_dest (Call by Reference)
;
; ebp+8: 	char* src
; ebp+12:	char** p_dest

SECTION .data
	msg_len DD 0

SECTION .text
	EXTERN strlen
	EXTERN calloc
	GLOBAL parseStr

parseStr:
	PUSH ebp
	MOV ebp, esp
	PUSH edi
	PUSH esi
	PUSH ebx

	; Berechnung der Stringlänge mittels CALL strlen
	MOV eax, dword [ebp+8]
	PUSH eax
	CALL strlen
	ADD esp, 4
	INC eax	; Schlusszeichen wurde nicht mitgezählt
	MOV dword [msg_len], eax	; Speichern in Variable

	;Speicherplatz reservieren
	PUSH 4
	PUSH eax
	CALL calloc
	ADD esp, 8

	MOV ebx, dword [ebp+12]	;Zeiger auf neuen String in übergebenem Zeiger speichern (Call by Reference)
	MOV [ebx], eax


	; Hier beginnt die Hauptroutine des Parsers
	; Initialisierungen
	MOV edi, 0	; Schleifenzähler
	MOV edx, eax	; edx ist startadresse des neuen Strings
	MOV esi, dword [ebp+8]	; edi ist startadresse des Eingabestrings
	MOV ecx, 0
	MOV eax, 0
L1:
	CMP edi, dword [msg_len]
	JGE exit

	MOV ebx, 0
	MOV bl, byte [esi+edi]	; ASCII Wert alter string in ebx
	CMP ebx, 58
	JGE noNumber
	CMP ebx, 48
	JL noNumber

	;Test auf Zahl erfolgreich. Hier gehts dann weiter mit der Zahl
	SUB ebx, 48	; Von ASCII zu Integer (Dezimal)
	IMUL ecx, 10
	ADD ecx, ebx
	JMP nextIt

noNumber:
	MOV byte [edx], bl
	INC edx
	ADD eax, ecx
	MOV ecx, 0

nextIt:
	INC edi
	JMP L1

exit:
	POP ebx
	POP esi
	POP edi
	MOV esp, ebp
	POP ebp
	RET
