 	AREA codigo, CODE, READONLY, ALIGN=2 
	THUMB	
	EXPORT Start
;-------------------------------------------
Start

	VLDR.F32 S0, =0			;valor de 'x' cos(x)
	VMOV.F32 S1, #1			; CTE '1'
	VMOV.F32 S2, #2			; CTE '2'	
	VLDR.F32 S3, =1			;'n' incio dela sumatoria	
	VLDR.F32 S4, =50		; fin de la sumatoria
	
	VMOV.F32 S5, #-1		;(-1) de la sumatoria
	VMOV.F32 S6, #-1		;(-1) para hacer la potencia

	VLDR.F32 S30, =1 		; en s30 se guarda el resultado
	VMOV.F32 S7, #1	   		; guardar factorial
	VMOV.F32 S8, #1			; guarda x^2n
;------------------------------------------------	
MULT
	VMUL.F32 S10, S2,S3 	;2*n
	VMOV.F32 S11, S10 		; S10=S11=2n
	VMOV.F32 S12, S10		;S12=S10=2n
;--------------------------------------------------
FACTOR						;(2n)!
	VMUL.F32 S7, S11 		;s7 = 2n*1
	VSUB.F32 S11, S1		;S11 = 2n-1
	VCMP.F32 S11, S1		;compara si s11=1
	VMRS APSR_nzcv, FPSCR
	BNE FACTOR
;---------------------------------------------------	
EXPO						; eleva x^(2n)	
	VMUL.F32 S8, S12,S11 	; S8 = 2n*2n
	VSUB.F32 S11, S1		; S11= 2n-1
	VCMP.F32 S11, S1		;compara si 2n=1
	VMRS APSR_nzcv, FPSCR
	BNE EXPO
;---------------------------------------------------	
NEGAR						;para (-1)^n
	VLDR.F32 S9, =-1		;(-1)
	VMUL.F32 S9,S6 			;(-1)(-1)
	VSUB.F32 S3, S1			; n-1
	VCMP.F32 S3,S1			;compara si  n=1
	VMRS APSR_nzcv, FPSCR
	BNE NEGAR
;---------------------------------------------------
SUMAR	
	VDIV.F32 S9, S7 		;s5 = (-1)/(2n)!
	VMUL.F32 S0, S9		;s5 = s5*(x)
	VADD.F32 S30, S0		;
	VADD.F32 S3, S1
	VCMP.F32 S3, S4
	VMRS APSR_nzcv, FPSCR
	BNE MULT
	
	ALIGN
	END
