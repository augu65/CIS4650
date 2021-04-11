* C-Minus Compilation to TM Code
* File: fac.tm
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
* processing var: fac
* <- varDec
* looking up id: x
 13:   LDA 0, -2(5)	load id address
* <- id
 14:    ST 0, -5(5)	op: push left
* -> call of function: input
 15:    ST 5, -6(5)	store current fp
 16:   LDA 5, -6(5)	push new frame
 17:   LDA 0, 1(7)	save return in ac
 18:   LDA 7, -15(7)	relative jump to function entry
 19:    LD 5, 0(5)	pop current frame
 20:    ST 0, -6(5)	store return
* <- call
 21:    LD 0, -5(5)	load left
 22:    LD 1, -6(5)	load right
 23:    ST 1, 0(0)	store in ac1
 24:    ST 1, -4(5)	assign: store value
* looking up id: fac
 25:   LDA 0, -3(5)	load id address
* <- id
 26:    ST 0, -7(5)	op: push left
* -> constant
 27:   LDC 0, 1(0)	load constant
* <- constant
 28:    ST 0, -8(5)	op: push left
 29:    LD 0, -7(5)	load left
 30:    LD 1, -8(5)	load right
 31:    ST 1, 0(0)	store in ac1
 32:    ST 1, -6(5)	assign: store value
* -> while
* -> mathExp
* looking up id: x
 33:    LD 0, -2(5)	load id value
* <- id
 34:    ST 0, -10(5)	op: push left
* -> constant
 35:   LDC 0, 1(0)	load constant
* <- constant
 36:    ST 0, -11(5)	op: push left
 37:    LD 0, -10(5)	load right
 38:    LD 1, -11(5)	load left
 39:   SUB 0, 0, 1	op >
 40:    ST 0, -9(5)	store value from math
* <- mathExp
* looking up id: fac
 42:   LDA 0, -3(5)	load id address
* <- id
 43:    ST 0, -10(5)	op: push left
* -> mathExp
* looking up id: fac
 44:    LD 0, -3(5)	load id value
* <- id
 45:    ST 0, -12(5)	op: push left
* looking up id: x
 46:    LD 0, -2(5)	load id value
* <- id
 47:    ST 0, -13(5)	op: push left
 48:    LD 0, -12(5)	load right
 49:    LD 1, -13(5)	load left
 50:   MUL 0, 0, 1	op *
 51:    ST 0, -11(5)	store value from math
* <- mathExp
 52:    LD 0, -10(5)	load left
 53:    LD 1, -11(5)	load right
 54:    ST 1, 0(0)	store in ac1
 55:    ST 1, -9(5)	assign: store value
* looking up id: x
 56:   LDA 0, -2(5)	load id address
* <- id
 57:    ST 0, -15(5)	op: push left
* -> mathExp
* looking up id: x
 58:    LD 0, -2(5)	load id value
* <- id
 59:    ST 0, -17(5)	op: push left
* -> constant
 60:   LDC 0, 1(0)	load constant
* <- constant
 61:    ST 0, -18(5)	op: push left
 62:    LD 0, -17(5)	load right
 63:    LD 1, -18(5)	load left
 64:   SUB 0, 0, 1	op -
 65:    ST 0, -16(5)	store value from math
* <- mathExp
 66:    LD 0, -15(5)	load left
 67:    LD 1, -16(5)	load right
 68:    ST 1, 0(0)	store in ac1
 69:    ST 1, -14(5)	assign: store value
 70:   LDA 7, -38(7)	while: absolute jump to test
 41:   JLT 0, 29(7)	while: jump to end
* <- while
* -> call of function: output
* looking up id: fac
 71:    LD 0, -3(5)	load id value
* <- id
 72:    ST 0, -19(5)	op: push left
 73:    LD 0, -19(5)	load value to ac
 74:    ST 0, -21(5)	store arg value
 75:    ST 5, -19(5)	store current fp
 76:   LDA 5, -19(5)	push new frame
 77:   LDA 0, 1(7)	save return in ac
 78:   LDA 7, -72(7)	relative jump to function entry
 79:    LD 5, 0(5)	pop current frame
 80:    ST 0, -19(5)	store return
* <- call
* <- compound statement
 81:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 70(7)	jump around func body
* <- funExp
 82:    ST 5, -20(5)	push ofp
 83:   LDA 5, -20(5)	push frame
 84:   LDA 0, 1(7)	load ac with ret ptr
 85:   LDA 7, -74(7) 	jump to main loc
 86:    LD 5, 0(5)	pop frame
* End of Execution
 87:  HALT 0, 0, 0	
