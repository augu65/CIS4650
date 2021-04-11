* C-Minus Compilation to TM Code
* File: gcd.tm
* Standard prelude:
  0:    LD 6, 0(0)	load gp with maxaddress
  1:   LDA 5, 0(6)	copy to gp to fp
  2:    ST 0, 0(0)	clear location 0
* Jump around i/o routines here
* code for input routine
  4:    ST 0, -1(5)	store return
  5:    IN 0, 0, 0	input
  6:    LD 7, -1(5)	return to caller
* code for output routine
  7:    ST 0, -1(5)	store return
  8:    LD 0, -2(5)	load output value
  9:   OUT 0, 0, 0	output
 10:    LD 7, -1(5)	return to caller
  3:   LDA 7, 7(7) 	jump around i/o code
* End of standard prelude.
* processing local var: y
* processing function: gcd
* jump around function body here
 12:    ST 0, -1(5)	save return address
* -> compound statement
 13:    LD 0, -2(5)	
 14:    ST 0, -6(5)	
 15:   LDC 0, 0(0)	
 16:    ST 0, -7(5)	
 17:    LD 0, -6(5)	
 18:    LD 1, -7(5)	
 19:   SUB 0, 0, 1	
 20:    ST 0, -5(5)	store
 22:    LD 0, -3(5)	
 23:    ST 0, -5(5)	
 21:   JNE 0, 3(7)	
 25:    LD 0, -2(5)	
 26:    ST 0, -5(5)	
 27:    LD 0, -3(5)	
 28:    ST 0, -7(5)	
 29:    LD 0, -3(5)	
 30:    ST 0, -10(5)	
 31:    LD 0, -2(5)	
 32:    ST 0, -11(5)	
 33:    LD 0, -10(5)	
 34:    LD 1, -11(5)	
 35:   DIV 0, 0, 1	
 36:    ST 0, -9(5)	store
 37:    LD 0, -2(5)	
 38:    ST 0, -10(5)	
 39:    LD 0, -9(5)	
 40:    LD 1, -10(5)	
 41:   MUL 0, 0, 1	
 42:    ST 0, -8(5)	store
 43:    LD 0, -7(5)	
 44:    LD 1, -8(5)	
 45:   SUB 0, 0, 1	
 46:    ST 0, -6(5)	store
 47:    LD 0, -9(5)	load value to ac
 48:    ST 0, -7(5)	store arg value
 49:    LD 0, -5(5)	load value to ac
 50:    ST 0, -8(5)	store arg value
 51:    ST 5, -5(5)	store current fp
 52:   LDA 5, -5(5)	push new frame
 53:   LDA 0, 1(7)	save return in ac
 54:   LDA 7, -43(7)	relative jump to function entry
 55:    LD 5, 0(5)	pop current frame
 56:    ST 0, -5(5)	store return
 24:   LDA 7, 32(7)	
 57:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 46(7)	jump forward to finale
* processing function: main
* jump around function body here
 59:    ST 0, -1(5)	save return address
* -> compound statement
* processing local var: x
 60:   LDA 0, -11(5)	
 61:    ST 0, -13(5)	
 62:    ST 5, -14(5)	store current fp
 63:   LDA 5, -14(5)	push new frame
 64:   LDA 0, 1(7)	save return in ac
 65:   LDA 7, -62(7)	relative jump to function entry
 66:    LD 5, 0(5)	pop current frame
 67:    ST 0, -14(5)	store return
 68:    LD 0, -13(5)	
 69:    LD 1, -14(5)	
 70:    ST 1, 0(0)	
 71:    ST 1, -12(5)	
 72:   LDA 0, -2(5)	
 73:    ST 0, -15(5)	
 74:   LDC 0, 10(0)	
 75:    ST 0, -16(5)	
 76:    LD 0, -15(5)	
 77:    LD 1, -16(5)	
 78:    ST 1, 0(0)	
 79:    ST 1, -14(5)	
 80:    LD 0, -11(5)	
 81:    ST 0, -17(5)	
 82:    LD 0, -2(5)	
 83:    ST 0, -18(5)	
 84:    LD 0, -18(5)	load value to ac
 85:    ST 0, -19(5)	store arg value
 86:    LD 0, -17(5)	load value to ac
 87:    ST 0, -20(5)	store arg value
 88:    ST 5, -17(5)	store current fp
 89:   LDA 5, -17(5)	push new frame
 90:   LDA 0, 1(7)	save return in ac
 91:   LDA 7, -80(7)	relative jump to function entry
 92:    LD 5, 0(5)	pop current frame
 93:    ST 0, -17(5)	store return
 94:    LD 0, -17(5)	load value to ac
 95:    ST 0, -19(5)	store arg value
 96:    LD 0, -18(5)	load value to ac
 97:    ST 0, -20(5)	store arg value
 98:    LD 0, -17(5)	load value to ac
 99:    ST 0, -21(5)	store arg value
100:    ST 5, -17(5)	store current fp
101:   LDA 5, -17(5)	push new frame
102:   LDA 0, 1(7)	save return in ac
103:   LDA 7, -97(7)	relative jump to function entry
104:    LD 5, 0(5)	pop current frame
105:    ST 0, -17(5)	store return
106:    LD 7, -1(5)	return back to the caller
 58:   LDA 7, 48(7)	jump forward to finale
107:    ST 5, -19(5)	push ofp
108:   LDA 5, -19(5)	push frame
109:   LDA 0, 1(7)	load ac with ret ptr
110:   LDA 7, -52(7) 	jump to main loc
111:    LD 5, 0(5)	pop frame
* End of Execution
112:  HALT 0, 0, 0	
