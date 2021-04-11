* C-Minus Compilation to TM Code
* File: 5.tm
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
* processing function: foo
* jump around function body here
 12:    ST 0, -1(5)	save return address
 13:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 2(7)	jump around func body
* <- funExp
* processing function: main
* jump around function body here
 15:    ST 0, -1(5)	save return address
* -> compound statement
* processing var: a
* -> constant
 16:   LDC 0, 2(0)	load constant
* <- constant
 17:    ST 0, -5(5)	op: push left
* <- varDec
* processing var: x
* <- varDec
* processing var: y
* <- varDec
* -> call of function: foo
* looking up id: x
 18:    LD 0, -8(5)	load id value
* <- id
 19:    ST 0, -11(5)	op: push left
* looking up id: x
 20:    LD 0, -8(5)	load id value
* <- id
 21:    ST 0, -12(5)	op: push left
* looking up id: x
 22:    LD 0, -8(5)	load id value
* <- id
 23:    ST 0, -13(5)	op: push left
 24:    LD 0, -13(5)	load value to ac
 25:    ST 0, -13(5)	store arg value
 26:    LD 0, -12(5)	load value to ac
 27:    ST 0, -14(5)	store arg value
 28:    LD 0, -11(5)	load value to ac
 29:    ST 0, -15(5)	store arg value
 30:    ST 5, -11(5)	store current fp
 31:   LDA 5, -11(5)	push new frame
 32:   LDA 0, 1(7)	save return in ac
 33:   LDA 7, -22(7)	relative jump to function entry
 34:    LD 5, 0(5)	pop current frame
 35:    ST 0, -11(5)	store return
* <- call
* looking up id: a
* -> array bounds check
 36:   LDC 0, 2(0)	load constant
 37:    LD 1, -11(5)	load id value
 38:   SUB 0, 1, 0	op -
 39:   JGT 0, 1(7)	bouns check: jump
 40:  HALT 0, 0, 0	out of bounds
* <- array bounds check
 41:   LDA 0, 6(5)	load id address
* <- id
 42:    ST 0, -11(5)	op: push left
* -> constant
 43:   LDC 0, 1(0)	load constant
* <- constant
 44:    ST 0, -12(5)	op: push left
 45:    LD 0, -11(5)	load left
 46:    LD 1, -12(5)	load right
 47:    ST 1, 0(0)	store in ac1
 48:    ST 1, -10(5)	assign: store value
* looking up id: x
 49:   LDA 0, -8(5)	load id address
* <- id
 50:    ST 0, -14(5)	op: push left
* -> mathExp
* -> mathExp
* looking up id: x
 51:    LD 0, -8(5)	load id value
* <- id
 52:    ST 0, -17(5)	op: push left
* -> constant
 53:   LDC 0, 2(0)	load constant
* <- constant
 54:    ST 0, -18(5)	op: push left
 55:    LD 0, -17(5)	load right
 56:    LD 1, -18(5)	load left
 57:   MUL 0, 0, 1	op *
 58:    ST 0, -16(5)	store value from math
* <- mathExp
* -> constant
 59:   LDC 0, 1(0)	load constant
* <- constant
 60:    ST 0, -17(5)	op: push left
 61:    LD 0, -16(5)	load right
 62:    LD 1, -17(5)	load left
 63:   ADD 0, 0, 1	op +
 64:    ST 0, -15(5)	store value from math
* <- mathExp
 65:    LD 0, -14(5)	load left
 66:    LD 1, -15(5)	load right
 67:    ST 1, 0(0)	store in ac1
 68:    ST 1, -13(5)	assign: store value
* looking up id: y
 69:   LDA 0, -9(5)	load id address
* <- id
 70:    ST 0, -21(5)	op: push left
* -> mathExp
* looking up id: x
 71:    LD 0, -8(5)	load id value
* <- id
 72:    ST 0, -23(5)	op: push left
* -> call of function: foo
* looking up id: x
 73:    LD 0, -8(5)	load id value
* <- id
 74:    ST 0, -24(5)	op: push left
* looking up id: x
 75:    LD 0, -8(5)	load id value
* <- id
 76:    ST 0, -25(5)	op: push left
* looking up id: x
 77:    LD 0, -8(5)	load id value
* <- id
 78:    ST 0, -26(5)	op: push left
 79:    LD 0, -26(5)	load value to ac
 80:    ST 0, -26(5)	store arg value
 81:    LD 0, -25(5)	load value to ac
 82:    ST 0, -27(5)	store arg value
 83:    LD 0, -24(5)	load value to ac
 84:    ST 0, -28(5)	store arg value
 85:    ST 5, -24(5)	store current fp
 86:   LDA 5, -24(5)	push new frame
 87:   LDA 0, 1(7)	save return in ac
 88:   LDA 7, -77(7)	relative jump to function entry
 89:    LD 5, 0(5)	pop current frame
 90:    ST 0, -24(5)	store return
* <- call
 91:    LD 0, -23(5)	load right
 92:    LD 1, -24(5)	load left
 93:   ADD 0, 0, 1	op +
 94:    ST 0, -22(5)	store value from math
* <- mathExp
 95:    LD 0, -21(5)	load left
 96:    LD 1, -22(5)	load right
 97:    ST 1, 0(0)	store in ac1
 98:    ST 1, -20(5)	assign: store value
* -> call of function: foo
 99:    ST 5, -27(5)	store current fp
100:   LDA 5, -27(5)	push new frame
101:   LDA 0, 1(7)	save return in ac
102:   LDA 7, -91(7)	relative jump to function entry
103:    LD 5, 0(5)	pop current frame
104:    ST 0, -27(5)	store return
* <- call
* <- compound statement
105:    LD 7, -1(5)	return back to the caller
 14:   LDA 7, 91(7)	jump around func body
* <- funExp
106:    ST 5, -27(5)	push ofp
107:   LDA 5, -27(5)	push frame
108:   LDA 0, 1(7)	load ac with ret ptr
109:   LDA 7, -95(7) 	jump to main loc
110:    LD 5, 0(5)	pop frame
* End of Execution
111:  HALT 0, 0, 0	
