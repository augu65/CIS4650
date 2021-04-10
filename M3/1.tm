* C-Minus Compilation to TM Code
* File: 1.tm
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
* processing local var: x
* processing function: test
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
 33:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 22(7)	jump forward to finale
* processing function: main
* jump around function body here
 35:    ST 0, -1(5)	save return address
* -> compound statement
* processing local var: o
* processing local var: u
* processing local var: v
 36:   LDA 0, -8(5)	
 37:    ST 0, -11(5)	
 38:   LDC 0, 7(0)	
 39:    ST 0, -12(5)	
 40:    LD 0, -11(5)	
 41:    LD 1, -12(5)	
 42:    ST 1, 0(0)	
 43:    ST 1, -10(5)	
 44:   LDA 0, -9(5)	
 45:    ST 0, -14(5)	
 46:   LDC 0, 2(0)	
 47:    ST 0, -15(5)	
 48:    LD 0, -14(5)	
 49:    LD 1, -15(5)	
 50:    ST 1, 0(0)	
 51:    ST 1, -13(5)	
 52:   LDA 0, -7(5)	
 53:    ST 0, -17(5)	
 54:    LD 0, -8(5)	
 55:    ST 0, -19(5)	
 56:    LD 0, -8(5)	
 57:    ST 0, -22(5)	
 58:    LD 0, -9(5)	
 59:    ST 0, -23(5)	
 60:    LD 0, -22(5)	
 61:    LD 1, -23(5)	
 62:   DIV 0, 0, 1	
 63:    ST 0, -21(5)	
 64:    LD 0, -9(5)	
 65:    ST 0, -22(5)	
 66:    LD 0, -21(5)	
 67:    LD 1, -22(5)	
 68:   MUL 0, 0, 1	
 69:    ST 0, -20(5)	
 70:    LD 0, -19(5)	
 71:    LD 1, -20(5)	
 72:   SUB 0, 0, 1	
 73:    ST 0, -18(5)	
 74:    LD 0, -17(5)	
 75:    LD 1, -18(5)	
 76:    ST 1, 0(0)	
 77:    ST 1, -16(5)	
 78:    LD 0, -7(5)	
 79:    ST 0, -23(5)	
 80:    LD 0, -23(5)	load value to ac
 81:    ST 0, -25(5)	store arg value
 82:    ST 5, -23(5)	store current fp
 83:   LDA 5, -23(5)	push new frame
 84:   LDA 0, 1(7)	save return in ac
 85:   LDA 7, -79(7)	relative jump to function entry
 86:    LD 5, 0(5)	pop current frame
 87:    ST 0, -23(5)	store return
 88:    LD 0, -7(5)	
 89:    ST 0, -24(5)	
 90:    LD 0, -8(5)	
 91:    ST 0, -26(5)	
 92:    LD 0, -8(5)	
 93:    ST 0, -29(5)	
 94:    LD 0, -9(5)	
 95:    ST 0, -30(5)	
 96:    LD 0, -29(5)	
 97:    LD 1, -30(5)	
 98:   DIV 0, 0, 1	
 99:    ST 0, -28(5)	
100:    LD 0, -9(5)	
101:    ST 0, -29(5)	
102:    LD 0, -28(5)	
103:    LD 1, -29(5)	
104:   MUL 0, 0, 1	
105:    ST 0, -27(5)	
106:    LD 0, -26(5)	
107:    LD 1, -27(5)	
108:   SUB 0, 0, 1	
109:    ST 0, -25(5)	
110:    LD 0, -24(5)	load value to ac
111:    ST 0, -26(5)	store arg value
112:    ST 5, -24(5)	store current fp
113:   LDA 5, -24(5)	push new frame
114:   LDA 0, 1(7)	save return in ac
115:   LDA 7, -104(7)	relative jump to function entry
116:    LD 5, 0(5)	pop current frame
117:    ST 0, -24(5)	store return
118:    LD 7, -1(5)	return back to the caller
 34:   LDA 7, 84(7)	jump forward to finale
119:    ST 5, -30(5)	push ofp
120:   LDA 5, -30(5)	push frame
121:   LDA 0, 1(7)	load ac with ret ptr
122:   LDA 7, -88(7) 	jump to main loc
123:    LD 5, 0(5)	pop frame
* End of Execution
124:  HALT 0, 0, 0	
