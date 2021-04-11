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
* processing function: main
* jump around function body here
 12:    ST 0, -1(5)	save return address
* -> compound statement
* processing var: o
* -> constant
 13:   LDC 0, 2(0)	load constant
* <- constant
 14:    ST 0, -2(5)	op: push left
* <- varDec
* processing var: y
* <- varDec
* looking up id: y
 15:   LDA 0, -5(5)	load id address
* <- id
 16:    ST 0, -7(5)	op: push left
* -> constant
 17:   LDC 0, 10(0)	load constant
* <- constant
 18:    ST 0, -8(5)	op: push left
 19:    LD 0, -7(5)	load left
 20:    LD 1, -8(5)	load right
 21:    ST 1, 0(0)	store in ac1
 22:    ST 1, -6(5)	assign: store value
* looking up id: y
 23:   LDA 0, -5(5)	load id address
* <- id
 24:    ST 0, -10(5)	op: push left
* looking up id: o
* -> array bounds check
 25:   LDC 0, 2(0)	load constant
 26:    LD 1, -10(5)	load id value
 27:   SUB 0, 1, 0	op -
 28:   JGT 0, 1(7)	bouns check: jump
 29:  HALT 0, 0, 0	out of bounds
* <- array bounds check
 30:   LDA 0, 8(5)	load id address
* <- id
 31:    ST 0, -10(5)	op: push left
* -> constant
 32:   LDC 0, 11(0)	load constant
* <- constant
 33:    ST 0, -11(5)	op: push left
 34:    LD 0, -10(5)	load left
 35:    LD 1, -11(5)	load right
 36:    ST 1, 0(0)	store in ac1
 37:    ST 1, -9(5)	assign: store value
* -> constant
 38:   LDC 0, 0(0)	load constant
* <- constant
 39:    ST 0, -13(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 40:   LDA 0, -2(5)	load id address
* <- id
 41:    ST 0, -13(5)	op: push left
* -> constant
 42:   LDC 0, 5(0)	load constant
* <- constant
 43:    ST 0, -14(5)	op: push left
 44:    LD 0, -13(5)	load left
 45:    LD 1, -14(5)	load right
 46:    ST 1, 0(0)	store in ac1
 47:    ST 1, -12(5)	assign: store value
* -> constant
 48:   LDC 0, 1(0)	load constant
* <- constant
 49:    ST 0, -16(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 50:   LDA 0, -3(5)	load id address
* <- id
 51:    ST 0, -16(5)	op: push left
* -> mathExp
* -> constant
 52:   LDC 0, 0(0)	load constant
* <- constant
 53:    ST 0, -18(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 54:    LD 0, -2(5)	load id value
* <- id
 55:    ST 0, -18(5)	op: push left
* -> constant
 56:   LDC 0, 7(0)	load constant
* <- constant
 57:    ST 0, -19(5)	op: push left
 58:    LD 0, -18(5)	load right
 59:    LD 1, -19(5)	load left
 60:   ADD 0, 0, 1	op +
 61:    ST 0, -17(5)	store value from math
* <- mathExp
 62:    LD 0, -16(5)	load left
 63:    LD 1, -17(5)	load right
 64:    ST 1, 0(0)	store in ac1
 65:    ST 1, -15(5)	assign: store value
* -> call of function: output
* -> constant
 66:   LDC 0, 0(0)	load constant
* <- constant
 67:    ST 0, -20(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 68:    LD 0, -2(5)	load id value
* <- id
 69:    ST 0, -20(5)	op: push left
 70:    LD 0, -20(5)	load value to ac
 71:    ST 0, -22(5)	store arg value
 72:    ST 5, -20(5)	store current fp
 73:   LDA 5, -20(5)	push new frame
 74:   LDA 0, 1(7)	save return in ac
 75:   LDA 7, -69(7)	relative jump to function entry
 76:    LD 5, 0(5)	pop current frame
 77:    ST 0, -20(5)	store return
* <- call
* -> call of function: output
* -> constant
 78:   LDC 0, 1(0)	load constant
* <- constant
 79:    ST 0, -21(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 80:    LD 0, -3(5)	load id value
* <- id
 81:    ST 0, -21(5)	op: push left
 82:    LD 0, -21(5)	load value to ac
 83:    ST 0, -23(5)	store arg value
 84:    ST 5, -21(5)	store current fp
 85:   LDA 5, -21(5)	push new frame
 86:   LDA 0, 1(7)	save return in ac
 87:   LDA 7, -81(7)	relative jump to function entry
 88:    LD 5, 0(5)	pop current frame
 89:    ST 0, -21(5)	store return
* <- call
* <- compound statement
 90:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 79(7)	jump around func body
* <- funExp
 91:    ST 5, -22(5)	push ofp
 92:   LDA 5, -22(5)	push frame
 93:   LDA 0, 1(7)	load ac with ret ptr
 94:   LDA 7, -83(7) 	jump to main loc
 95:    LD 5, 0(5)	pop frame
* End of Execution
 96:  HALT 0, 0, 0	
