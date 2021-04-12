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
* processing function: test
* jump around function body here
 12:    ST 0, -1(5)	save return address
* -> compound statement
* -> call of function: output
* -> constant
 13:   LDC 0, 0(0)	load constant
* <- constant
 14:    ST 0, -3(5)	op: push left
* looking up id: a
 15:  HALT 0, 0, 0	out of bounds
 16:    LD 0, -2(5)	load id value
* <- id
 17:    ST 0, -3(5)	op: push left
 18:    LD 0, -3(5)	load value to ac
 19:    ST 0, -5(5)	store arg value
 20:    ST 5, -3(5)	store current fp
 21:   LDA 5, -3(5)	push new frame
 22:   LDA 0, 1(7)	save return in ac
 23:   LDA 7, -17(7)	relative jump to function entry
 24:    LD 5, 0(5)	pop current frame
 25:    ST 0, -3(5)	store return
* <- call
* -> call of function: output
* -> constant
 26:   LDC 0, 4(0)	load constant
* <- constant
 27:    ST 0, -4(5)	op: push left
 28:    LD 0, -4(5)	load value to ac
 29:    ST 0, -6(5)	store arg value
 30:    ST 5, -4(5)	store current fp
 31:   LDA 5, -4(5)	push new frame
 32:   LDA 0, 1(7)	save return in ac
 33:   LDA 7, -27(7)	relative jump to function entry
 34:    LD 5, 0(5)	pop current frame
 35:    ST 0, -4(5)	store return
* <- call
* <- compound statement
 36:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 25(7)	jump around func body
* <- funExp
* processing function: main
* jump around function body here
 38:    ST 0, -1(5)	save return address
* -> compound statement
* processing var: o
* -> constant
 39:   LDC 0, 2(0)	load constant
* <- constant
 40:    ST 0, -5(5)	op: push left
* <- varDec
* processing var: y
* <- varDec
* looking up id: y
 41:   LDA 0, -8(5)	load id address
* <- id
 42:    ST 0, -10(5)	op: push left
* -> constant
 43:   LDC 0, 10(0)	load constant
* <- constant
 44:    ST 0, -11(5)	op: push left
 45:    LD 0, -10(5)	load left
 46:    LD 1, -11(5)	load right
 47:    ST 1, 0(0)	store in ac1
 48:    ST 1, -9(5)	assign: store value
* -> constant
 49:   LDC 0, 0(0)	load constant
* <- constant
 50:    ST 0, -13(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 51:   LDA 0, -5(5)	load id address
* <- id
 52:    ST 0, -13(5)	op: push left
* -> constant
 53:   LDC 0, 5(0)	load constant
* <- constant
 54:    ST 0, -14(5)	op: push left
 55:    LD 0, -13(5)	load left
 56:    LD 1, -14(5)	load right
 57:    ST 1, 0(0)	store in ac1
 58:    ST 1, -12(5)	assign: store value
* -> constant
 59:   LDC 0, 1(0)	load constant
* <- constant
 60:    ST 0, -16(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 61:   LDA 0, -6(5)	load id address
* <- id
 62:    ST 0, -16(5)	op: push left
* -> mathExp
* -> constant
 63:   LDC 0, 0(0)	load constant
* <- constant
 64:    ST 0, -18(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 65:    LD 0, -5(5)	load id value
* <- id
 66:    ST 0, -18(5)	op: push left
* -> constant
 67:   LDC 0, 7(0)	load constant
* <- constant
 68:    ST 0, -19(5)	op: push left
 69:    LD 0, -18(5)	load right
 70:    LD 1, -19(5)	load left
 71:   ADD 0, 0, 1	op +
 72:    ST 0, -17(5)	store value from math
* <- mathExp
 73:    LD 0, -16(5)	load left
 74:    LD 1, -17(5)	load right
 75:    ST 1, 0(0)	store in ac1
 76:    ST 1, -15(5)	assign: store value
* -> call of function: output
* -> constant
 77:   LDC 0, 0(0)	load constant
* <- constant
 78:    ST 0, -20(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 79:    LD 0, -5(5)	load id value
* <- id
 80:    ST 0, -20(5)	op: push left
 81:    LD 0, -20(5)	load value to ac
 82:    ST 0, -22(5)	store arg value
 83:    ST 5, -20(5)	store current fp
 84:   LDA 5, -20(5)	push new frame
 85:   LDA 0, 1(7)	save return in ac
 86:   LDA 7, -80(7)	relative jump to function entry
 87:    LD 5, 0(5)	pop current frame
 88:    ST 0, -20(5)	store return
* <- call
* -> call of function: output
* -> constant
 89:   LDC 0, 1(0)	load constant
* <- constant
 90:    ST 0, -21(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 91:    LD 0, -6(5)	load id value
* <- id
 92:    ST 0, -21(5)	op: push left
 93:    LD 0, -21(5)	load value to ac
 94:    ST 0, -23(5)	store arg value
 95:    ST 5, -21(5)	store current fp
 96:   LDA 5, -21(5)	push new frame
 97:   LDA 0, 1(7)	save return in ac
 98:   LDA 7, -92(7)	relative jump to function entry
 99:    LD 5, 0(5)	pop current frame
100:    ST 0, -21(5)	store return
* <- call
* -> call of function: test
* looking up id: o
101:  HALT 0, 0, 0	out of bounds
102:    LD 0, -5(5)	load id value
* <- id
103:    ST 0, -22(5)	op: push left
104:    LD 0, -22(5)	load value to ac
105:    ST 0, -24(5)	store arg value
106:    ST 5, -22(5)	store current fp
107:   LDA 5, -22(5)	push new frame
108:   LDA 0, 1(7)	save return in ac
109:   LDA 7, -98(7)	relative jump to function entry
110:    LD 5, 0(5)	pop current frame
111:    ST 0, -22(5)	store return
* <- call
* <- compound statement
112:    LD 7, -1(5)	return back to the caller
 37:   LDA 7, 75(7)	jump around func body
* <- funExp
113:    ST 5, -23(5)	push ofp
114:   LDA 5, -23(5)	push frame
115:   LDA 0, 1(7)	load ac with ret ptr
116:   LDA 7, -79(7) 	jump to main loc
117:    LD 5, 0(5)	pop frame
* End of Execution
118:  HALT 0, 0, 0	
