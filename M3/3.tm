* C-Minus Compilation to TM Code
* File: 3.tm
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
* looking up id: y
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
* -> if
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
 39:   SUB 0, 0, 1	op ==
 40:    ST 0, -9(5)	store value from math
* <- mathExp
* looking up id: y
 42:   LDA 0, -3(5)	load id address
* <- id
 43:    ST 0, -10(5)	op: push left
* -> constant
 44:   LDC 0, 2(0)	load constant
* <- constant
 45:    ST 0, -11(5)	op: push left
 46:    LD 0, -10(5)	load left
 47:    LD 1, -11(5)	load right
 48:    ST 1, 0(0)	store in ac1
 49:    ST 1, -9(5)	assign: store value
 41:   JNE 0, 9(7)	if: jump to else
* looking up id: y
 51:   LDA 0, -3(5)	load id address
* <- id
 52:    ST 0, -10(5)	op: push left
* -> constant
 53:   LDC 0, 100(0)	load constant
* <- constant
 54:    ST 0, -11(5)	op: push left
 55:    LD 0, -10(5)	load left
 56:    LD 1, -11(5)	load right
 57:    ST 1, 0(0)	store in ac1
 58:    ST 1, -9(5)	assign: store value
 50:   LDA 7, 8(7)	jump to end
* <- if
* -> call of function: output
* looking up id: y
 59:    LD 0, -3(5)	load id value
* <- id
 60:    ST 0, -12(5)	op: push left
 61:    LD 0, -12(5)	load value to ac
 62:    ST 0, -14(5)	store arg value
 63:    ST 5, -12(5)	store current fp
 64:   LDA 5, -12(5)	push new frame
 65:   LDA 0, 1(7)	save return in ac
 66:   LDA 7, -60(7)	relative jump to function entry
 67:    LD 5, 0(5)	pop current frame
 68:    ST 0, -12(5)	store return
* <- call
* <- compound statement
 69:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 58(7)	jump around func body
* <- funExp
 70:    ST 5, -13(5)	push ofp
 71:   LDA 5, -13(5)	push frame
 72:   LDA 0, 1(7)	load ac with ret ptr
 73:   LDA 7, -62(7) 	jump to main loc
 74:    LD 5, 0(5)	pop frame
* End of Execution
 75:  HALT 0, 0, 0	
