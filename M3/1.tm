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
* -> constant
 23:   LDC 0, 0(0)	load constant
* <- constant
 24:    ST 0, -10(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 25:   LDA 0, -2(5)	load id address
* <- id
 26:    ST 0, -10(5)	op: push left
* -> constant
 27:   LDC 0, 5(0)	load constant
* <- constant
 28:    ST 0, -11(5)	op: push left
 29:    LD 0, -10(5)	load left
 30:    LD 1, -11(5)	load right
 31:    ST 1, 0(0)	store in ac1
 32:    ST 1, -9(5)	assign: store value
* -> constant
 33:   LDC 0, 1(0)	load constant
* <- constant
 34:    ST 0, -13(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 35:   LDA 0, -3(5)	load id address
* <- id
 36:    ST 0, -13(5)	op: push left
* -> mathExp
* -> constant
 37:   LDC 0, 0(0)	load constant
* <- constant
 38:    ST 0, -15(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 39:    LD 0, -2(5)	load id value
* <- id
 40:    ST 0, -15(5)	op: push left
* -> constant
 41:   LDC 0, 7(0)	load constant
* <- constant
 42:    ST 0, -16(5)	op: push left
 43:    LD 0, -15(5)	load right
 44:    LD 1, -16(5)	load left
 45:   ADD 0, 0, 1	op +
 46:    ST 0, -14(5)	store value from math
* <- mathExp
 47:    LD 0, -13(5)	load left
 48:    LD 1, -14(5)	load right
 49:    ST 1, 0(0)	store in ac1
 50:    ST 1, -12(5)	assign: store value
* -> call of function: output
* -> constant
 51:   LDC 0, 0(0)	load constant
* <- constant
 52:    ST 0, -17(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 53:    LD 0, -2(5)	load id value
* <- id
 54:    ST 0, -17(5)	op: push left
 55:    LD 0, -17(5)	load value to ac
 56:    ST 0, -19(5)	store arg value
 57:    ST 5, -17(5)	store current fp
 58:   LDA 5, -17(5)	push new frame
 59:   LDA 0, 1(7)	save return in ac
 60:   LDA 7, -54(7)	relative jump to function entry
 61:    LD 5, 0(5)	pop current frame
 62:    ST 0, -17(5)	store return
* <- call
* -> call of function: output
* -> constant
 63:   LDC 0, 1(0)	load constant
* <- constant
 64:    ST 0, -18(5)	op: push left
* looking up id: o
* -> array bounds check
* <- array bounds check
 65:    LD 0, -3(5)	load id value
* <- id
 66:    ST 0, -18(5)	op: push left
 67:    LD 0, -18(5)	load value to ac
 68:    ST 0, -20(5)	store arg value
 69:    ST 5, -18(5)	store current fp
 70:   LDA 5, -18(5)	push new frame
 71:   LDA 0, 1(7)	save return in ac
 72:   LDA 7, -66(7)	relative jump to function entry
 73:    LD 5, 0(5)	pop current frame
 74:    ST 0, -18(5)	store return
* <- call
* <- compound statement
 75:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 64(7)	jump around func body
* <- funExp
 76:    ST 5, -19(5)	push ofp
 77:   LDA 5, -19(5)	push frame
 78:   LDA 0, 1(7)	load ac with ret ptr
 79:   LDA 7, -68(7) 	jump to main loc
 80:    LD 5, 0(5)	pop frame
* End of Execution
 81:  HALT 0, 0, 0	
