	THUMB        
    AREA    |.text|, CODE, READONLY, ALIGN=2
    EXPORT  Start
	   
Start	
;Valores matriz 2x2:
	vldr.f32 s1,	=1 ;|s1 , s3|
	vldr.f32 s2,	=2 ;|s2 , s4|
	vldr.f32 s3,	=3
	vldr.f32 s4,	=4
;valores matriz 3x3	
	vldr.f32 s10,	=1
	vldr.f32 s11,	=2
	vldr.f32 s12,	=3
	vldr.f32 s13,	=2 ; |s10 , s13 , s16 |
	vldr.f32 s14,	=1 ; |s11 , s14 , s17 |
	vldr.f32 s15,	=1 ; |s12 , s15 , s18 |
	vldr.f32 s16, 	=3
	vldr.f32 s17,	=1
	vldr.f32 s18,	=1
	
DET2
	vmul.f32 s5, s1,s4
	vmul.f32 s6, s2,s3
	vsub.f32 s7, s5,s6; ;Guardar en s7
	
	B DET3
DET3
	vmul.f32 s19, s14, s18
	vmul.f32 s20, s17, s15
	
	vmul.f32 s21, s11, s18
	vmul.f32 s22, s12, s17

	vmul.f32 s23, s11, s15
	vmul.f32 s24, s12, s14
	
	vsub.f32 s25, s19, s20
	vsub.f32 s26, s21, s22
	vsub.f32 s27, s23, s24
	
	vmul.f32 s1, s10, s25
	vmul.f32 s2, s13, s26
	vmul.f32 s3, s16, s27
	
	vadd.f32 s28, s1, s3
	vsub.f32 s30, s28, s2;Guardar en s30;
	
	NOP
	ALIGN
	END	