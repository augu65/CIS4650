* C-Minus Compilation to TM Code
* File: 2.tm
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
* processing var: x
* <- varDec
* processing var: y
* <- varDec
* looking up id: x
 13:   LDA 0, -2(5)	load id address
* <- id
 14:    ST 0, -5(5)	op: push left
* -> constant
 15:   LDC 0, 7(0)	load constant
* <- constant
 16:    ST 0, -6(5)	op: push left
 17:    LD 0, -5(5)	load left
 18:    LD 1, -6(5)	load right
 19:    ST 1, 0(0)	store in ac1
 20:    ST 1, -4(5)	assign: store value
* looking up id: y
 21:   LDA 0, -3(5)	load id address
* <- id
 22:    ST 0, -8(5)	op: push left
* -> constant
 23:   LDC 0, 1(0)	load constant
* <- constant
 24:    ST 0, -9(5)	op: push left
 25:    LD 0, -8(5)	load left
 26:    LD 1, -9(5)	load right
 27:    ST 1, 0(0)	store in ac1
 28:    ST 1, -7(5)	assign: store value
* -> while
* -> mathExp
* looking up id: x
 29:    LD 0, -2(5)	load id value
* <- id
 30:    ST 0, -11(5)	op: push left
* -> constant
 31:   LDC 0, 1(0)	load constant
* <- constant
 32:    ST 0, -12(5)	op: push left
 33:    LD 0, -11(5)	load right
 34:    LD 1, -12(5)	load left
 35:   SUB 0, 0, 1	op >
 36:    ST 0, -10(5)	store value from math
* <- mathExp
* looking up id: x
 38:   LDA 0, -2(5)	load id address
* <- id
 39:    ST 0, -11(5)	op: push left
* -> mathExp
* looking up id: x
 40:    LD 0, -2(5)	load id value
* <- id
 41:    ST 0, -13(5)	op: push left
* -> constant
 42:   LDC 0, 1(0)	load constant
* <- constant
 43:    ST 0, -14(5)	op: push left
 44:    LD 0, -13(5)	load right
 45:    LD 1, -14(5)	load left
 46:   SUB 0, 0, 1	op -
 47:    ST 0, -12(5)	store value from math
* <- mathExp
 48:    LD 0, -11(5)	load left
 49:    LD 1, -12(5)	load right
 50:    ST 1, 0(0)	store in ac1
 51:    ST 1, -10(5)	assign: store value
* looking up id: y
 52:   LDA 0, -3(5)	load id address
* <- id
 53:    ST 0, -16(5)	op: push left
* -> mathExp
* looking up id: y
 54:    LD 0, -3(5)	load id value
* <- id
 55:    ST 0, -18(5)	op: push left
* -> constant
 56:   LDC 0, 2(0)	load constant
* <- constant
 57:    ST 0, -19(5)	op: push left
 58:    LD 0, -18(5)	load right
 59:    LD 1, -19(5)	load left
 60:   MUL 0, 0, 1	op *
 61:    ST 0, -17(5)	store value from math
* <- mathExp
 62:    LD 0, -16(5)	load left
 63:    LD 1, -17(5)	load right
 64:    ST 1, 0(0)	store in ac1
 65:    ST 1, -15(5)	assign: store value
 66:   LDA 7, -38(7)	while: absolute jump to test
 37:   JLT 0, 29(7)	while: jump to end
* <- while
* -> call of function: output
* looking up id: y
 67:    LD 0, -3(5)	load id value
* <- id
 68:    ST 0, -20(5)	op: push left
 69:    LD 0, -20(5)	load value to ac
 70:    ST 0, -22(5)	store arg value
 71:    ST 5, -20(5)	store current fp
 72:   LDA 5, -20(5)	push new frame
 73:   LDA 0, 1(7)	save return in ac
 74:   LDA 7, -68(7)	relative jump to function entry
 75:    LD 5, 0(5)	pop current frame
 76:    ST 0, -20(5)	store return
* <- call
* <- compound statement
 77:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 66(7)	jump around func body
* <- funExp
 78:    ST 5, -21(5)	push ofp
 79:   LDA 5, -21(5)	push frame
 80:   LDA 0, 1(7)	load ac with ret ptr
 81:   LDA 7, -70(7) 	jump to main loc
 82:    LD 5, 0(5)	pop frame
* End of Execution
 83:  HALT 0, 0, 0	
