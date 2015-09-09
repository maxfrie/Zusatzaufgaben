; float scalar_product_sse(float* x, float* y, int veclength)
;
; ebp+8:	float* x
; ebp+12:	float* y
; ebp+16:	int veclength

SECTION .text
	GLOBAL scalar_product_sse

scalar_product_sse:
	PUSH ebp
	MOV ebp, esp

	; Register initialisieren
	MOV eax, dword [ebp+8]	; Basisadresse von x
	MOV edx, dword [ebp+12]	; Basisadresse von y
	MOV ecx, 0	;Schleifenzähler
	XORPS xmm0, xmm0	; xmm0 = 0
	
L1:
	CMP ecx, dword [ebp+16]
	JGE break

	MOVUPS xmm1, [eax+ecx*4]
	MOVUPS xmm2, [edx+ecx*4]
	MULPS xmm1, xmm2
	ADDPS xmm0, xmm1

	ADD ecx, 4
	JMP L1

break:
	; Zwischenergebnisse in xmm0 werden nun aufsummiert
	XORPS xmm1, xmm1
	MOV ecx, dword [ebp+16]
L2:
	ADDSS xmm1, xmm0
	SHUFPS xmm0, xmm0, 0x39	;Inhalt von xmm0 nach rechts rotieren
	LOOP L2

	; Ergebnis aus xmm1[0] speichern
	MOV eax, dword [ebp+20]
	MOVSS [eax], xmm1

exit:
	MOV esp, ebp
	POP ebp
	RET
