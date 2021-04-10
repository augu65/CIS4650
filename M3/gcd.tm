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
 14:    ST 0, -5(5)	
 15:    LD 0, -5(5)	load value to ac
 16:    ST 0, -7(5)	store arg value
 17:    ST 5, -5(5)	store current fp
 18:   LDA 5, -5(5)	push new frame
 19:   LDA 0, 1(7)	save return in ac
 20:   LDA 7, -14(7)	relative jump to function entry
 21:    LD 5, 0(5)	pop current frame
 22:    ST 0, -5(5)	store return
 23:    LD 0, 1(5)	
 24:    ST 0, -6(5)	
 25:    LD 0, -6(5)	load value to ac
 26:    ST 0, -8(5)	store arg value
 27:    ST 5, -6(5)	store current fp
 28:   LDA 5, -6(5)	push new frame
 29:   LDA 0, 1(7)	save return in ac
 30:   LDA 7, -24(7)	relative jump to function entry
 31:    LD 5, 0(5)	pop current frame
 32:    ST 0, -6(5)	store return
 33:    LD 0, 1(5)	
 34:    ST 0, -8(5)	
 35:   LDC 0, 0(0)	
 36:    ST 0, -9(5)	
 37:    LD 0, -8(5)	
 38:    LD 1, -9(5)	
 39:   SUB 0, 0, 1	
 40:    ST 0, -7(5)	
 42:    LD 0, -2(5)	
 43:    ST 0, -7(5)	
 41:   JNE 0, 3(7)	
* processing local var: t
 45:   LDA 0, -7(5)	
 46:    ST 0, -9(5)	
 47:    LD 0, -2(5)	
 48:    ST 0, -11(5)	
 49:    LD 0, -2(5)	
 50:    ST 0, -14(5)	
 51:    LD 0, 1(5)	
 52:    ST 0, -15(5)	
 53:    LD 0, -14(5)	
 54:    LD 1, -15(5)	
 55:   DIV 0, 0, 1	
 56:    ST 0, -13(5)	
 57:    LD 0, 1(5)	
 58:    ST 0, -14(5)	
 59:    LD 0, -13(5)	
 60:    LD 1, -14(5)	
 61:   MUL 0, 0, 1	
 62:    ST 0, -12(5)	
 63:    LD 0, -11(5)	
 64:    LD 1, -12(5)	
 65:   SUB 0, 0, 1	
 66:    ST 0, -10(5)	
 67:    LD 0, -9(5)	
 68:    LD 1, -10(5)	
 69:    ST 1, 0(0)	
 70:    ST 1, -8(5)	
 71:    LD 0, 1(5)	
 72:    ST 0, -15(5)	
 73:    LD 0, -7(5)	
 74:    ST 0, -16(5)	
 75:    LD 0, -15(5)	load value to ac
 76:    ST 0, -17(5)	store arg value
 77:    LD 0, -16(5)	load value to ac
 78:    ST 0, -18(5)	store arg value
 79:    ST 5, -15(5)	store current fp
 80:   LDA 5, -15(5)	push new frame
 81:   LDA 0, 1(7)	save return in ac
 82:   LDA 7, -71(7)	relative jump to function entry
 83:    LD 5, 0(5)	pop current frame
 84:    ST 0, -15(5)	store return
 44:   LDA 7, 40(7)	
 85:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 74(7)	jump forward to finale
* processing function: main
* jump around function body here
 87:    ST 0, -1(5)	save return address
* -> compound statement
* processing local var: x
 88:   LDA 0, -17(5)	
 89:    ST 0, -19(5)	
 90:   LDC 0, 25(0)	
 91:    ST 0, -20(5)	
 92:    LD 0, -19(5)	
 93:    LD 1, -20(5)	
 94:    ST 1, 0(0)	
 95:    ST 1, -18(5)	
 96:   LDA 0, -2(5)	
 97:    ST 0, -22(5)	
 98:   LDC 0, 10(0)	
 99:    ST 0, -23(5)	
100:    LD 0, -22(5)	
101:    LD 1, -23(5)	
102:    ST 1, 0(0)	
103:    ST 1, -21(5)	
104:    LD 0, -17(5)	
105:    ST 0, -24(5)	
106:    LD 0, -2(5)	
107:    ST 0, -25(5)	
108:    LD 0, -24(5)	load value to ac
109:    ST 0, -26(5)	store arg value
110:    LD 0, -25(5)	load value to ac
111:    ST 0, -27(5)	store arg value
112:    ST 5, -24(5)	store current fp
113:   LDA 5, -24(5)	push new frame
114:   LDA 0, 1(7)	save return in ac
115:   LDA 7, -104(7)	relative jump to function entry
116:    LD 5, 0(5)	pop current frame
117:    ST 0, -24(5)	store return
118:    LD 0, -24(5)	load value to ac
119:    ST 0, -26(5)	store arg value
120:    ST 5, -24(5)	store current fp
121:   LDA 5, -24(5)	push new frame
122:   LDA 0, 1(7)	save return in ac
123:   LDA 7, -117(7)	relative jump to function entry
124:    LD 5, 0(5)	pop current frame
125:    ST 0, -24(5)	store return
126:    LD 7, -1(5)	return back to the caller
 86:   LDA 7, 40(7)	jump forward to finale
127:    ST 5, -26(5)	push ofp
128:   LDA 5, -26(5)	push frame
129:   LDA 0, 1(7)	load ac with ret ptr
130:   LDA 7, -44(7) 	jump to main loc
131:    LD 5, 0(5)	pop frame
* End of Execution
132:  HALT 0, 0, 0	
