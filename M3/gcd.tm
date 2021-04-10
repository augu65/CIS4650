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
* processing local var: j
 25:   LDA 0, -5(5)	
 26:    ST 0, -7(5)	
 27:    LD 0, -3(5)	
 28:    ST 0, -9(5)	
 29:    LD 0, -3(5)	
 30:    ST 0, -12(5)	
 31:    LD 0, -2(5)	
 32:    ST 0, -13(5)	
 33:    LD 0, -12(5)	
 34:    LD 1, -13(5)	
 35:   DIV 0, 0, 1	
 36:    ST 0, -11(5)	store
 37:    LD 0, -2(5)	
 38:    ST 0, -12(5)	
 39:    LD 0, -11(5)	
 40:    LD 1, -12(5)	
 41:   MUL 0, 0, 1	
 42:    ST 0, -10(5)	store
 43:    LD 0, -9(5)	
 44:    LD 1, -10(5)	
 45:   SUB 0, 0, 1	
 46:    ST 0, -8(5)	store
 47:    LD 0, -7(5)	
 48:    LD 1, -8(5)	
 49:    ST 1, 0(0)	
 50:    ST 1, -6(5)	
 51:    LD 0, -2(5)	
 52:    ST 0, -13(5)	
 53:    LD 0, -5(5)	
 54:    ST 0, -14(5)	
 55:    LD 0, -14(5)	load value to ac
 56:    ST 0, -15(5)	store arg value
 57:    LD 0, -13(5)	load value to ac
 58:    ST 0, -16(5)	store arg value
 59:    ST 5, -13(5)	store current fp
 60:   LDA 5, -13(5)	push new frame
 61:   LDA 0, 1(7)	save return in ac
 62:   LDA 7, -51(7)	relative jump to function entry
 63:    LD 5, 0(5)	pop current frame
 64:    ST 0, -13(5)	store return
 24:   LDA 7, 40(7)	
 65:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 54(7)	jump forward to finale
* processing function: main
* jump around function body here
 67:    ST 0, -1(5)	save return address
* -> compound statement
* processing local var: x
 68:   LDA 0, -15(5)	
 69:    ST 0, -17(5)	
 70:    ST 5, -18(5)	store current fp
 71:   LDA 5, -18(5)	push new frame
 72:   LDA 0, 1(7)	save return in ac
 73:   LDA 7, -70(7)	relative jump to function entry
 74:    LD 5, 0(5)	pop current frame
 75:    ST 0, -18(5)	store return
 76:    LD 0, -17(5)	
 77:    LD 1, -18(5)	
 78:    ST 1, 0(0)	
 79:    ST 1, -16(5)	
 80:   LDA 0, -2(5)	
 81:    ST 0, -19(5)	
 82:   LDC 0, 10(0)	
 83:    ST 0, -20(5)	
 84:    LD 0, -19(5)	
 85:    LD 1, -20(5)	
 86:    ST 1, 0(0)	
 87:    ST 1, -18(5)	
 88:    LD 0, -15(5)	
 89:    ST 0, -21(5)	
 90:    LD 0, -2(5)	
 91:    ST 0, -22(5)	
 92:    LD 0, -22(5)	load value to ac
 93:    ST 0, -23(5)	store arg value
 94:    LD 0, -21(5)	load value to ac
 95:    ST 0, -24(5)	store arg value
 96:    ST 5, -21(5)	store current fp
 97:   LDA 5, -21(5)	push new frame
 98:   LDA 0, 1(7)	save return in ac
 99:   LDA 7, -88(7)	relative jump to function entry
100:    LD 5, 0(5)	pop current frame
101:    ST 0, -21(5)	store return
102:    LD 0, -21(5)	load value to ac
103:    ST 0, -23(5)	store arg value
104:    LD 0, -22(5)	load value to ac
105:    ST 0, -24(5)	store arg value
106:    LD 0, -21(5)	load value to ac
107:    ST 0, -25(5)	store arg value
108:    ST 5, -21(5)	store current fp
109:   LDA 5, -21(5)	push new frame
110:   LDA 0, 1(7)	save return in ac
111:   LDA 7, -105(7)	relative jump to function entry
112:    LD 5, 0(5)	pop current frame
113:    ST 0, -21(5)	store return
114:    LD 7, -1(5)	return back to the caller
 66:   LDA 7, 48(7)	jump forward to finale
115:    ST 5, -23(5)	push ofp
116:   LDA 5, -23(5)	push frame
117:   LDA 0, 1(7)	load ac with ret ptr
118:   LDA 7, -52(7) 	jump to main loc
119:    LD 5, 0(5)	pop frame
* End of Execution
120:  HALT 0, 0, 0	
