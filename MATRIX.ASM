; ============================================================================
; !]>                         AUTHOR  - alkat45                            <[!
; !]>                         CREATED - 04.11.2026                         <[!
; !]>                         LICENSE - GPLv3                              <[!
; !]>                         NAME    - MATRIX                             <[!
; !]>                         VERSION - 1.2                                <[!
; ============================================================================

IDEAL
MODEL TINY
CODESEG
ORG 00100H

; WITH CHANCE P% GOD TO DO SOMETHING
; K   = ROUND(P% * MAX_NUM)
;     = MAX - MIN + 1
; P%  = K / MAX_NUM
; MAX = K + MIN - 1
; MIN = K - MAX - 1 = 0
MAX    EQU 25

START:
	; POINT ES TO VRAM
	MOV AX, 0B800H
	MOV ES, AX

	; GENERATE A SEED FOR LFSR
	XOR AH, AH
	INT 01AH

@@MAIN_LOOP:
	MOV CX, 80
	MOV DI, 1
@@MAKE_STEP_IN_COLUM:
	; GENERATE A PSEUDRANDOM NUMBER
	SHR DL, 1
	JNC @@SKIP_LFSR
	XOR DL, 0B8H
@@SKIP_LFSR:

	; CHECK FOR A NON-TRIGGERING CHANCE
	CMP DL, MAX             ; DL > MAX
	JA @@GOD_DO_NOTHING

	CMP [BYTE ES:DI], 002H  ; IS AT GOD IT ANCESTRO?
	JE @@GOD_CREATE_DEATH

	; GOD CREATE A DESCENDANT OR DEATH

	MOV [BYTE ES:DI - 1], DL
	MOV [BYTE ES:DI], 00FH
	JMP SHORT @@END_MAKE_STEP_IN_COLUM

@@GOD_CREATE_DEATH:
	MOV [BYTE ES:DI], 000H
	JMP SHORT @@END_MAKE_STEP_IN_COLUM

	; GOD DO NOTHING
@@GOD_DO_NOTHING:            
			      
	MOV BL, 24
	ADD DI, 3840
@@MAKE_AUTOMATON_RULES_LOOP_IN_COLUM:
	SUB DI, 160
	
	; DESCENDANT
	CMP [BYTE ES:DI], 00FH
	JNE @@CHECK_DEATH

	MOV [BYTE ES:DI + 159], DL
	MOV [BYTE ES:DI + 160], 0FH
	MOV [BYTE ES:DI], 002H

	; DEATH
@@CHECK_DEATH:
	CMP [BYTE ES:DI], 000H
	JNE @@CONTINUE_MAKING_AUTOMATON_RULES_LOOP_IN_COLUM

	MOV [WORD ES:DI + 160], AX

@@CONTINUE_MAKING_AUTOMATON_RULES_LOOP_IN_COLUM:
	DEC BL
	JNZ @@MAKE_AUTOMATON_RULES_LOOP_IN_COLUM

	CMP [BYTE ES:DI + 3840], 00FH
	JNE @@END_MAKE_STEP_IN_COLUM
	MOV [BYTE ES:DI + 3840], 002H

@@END_MAKE_STEP_IN_COLUM:
	ADD DI, 2
	LOOP @@MAKE_STEP_IN_COLUM

	JMP SHORT @@MAIN_LOOP

END START
