* C-Minus Compilation to TM Code
* File: 4.tm
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
* -> if
* -> mathExp
* looking up id: a
 13:    LD 0, -2(5)	load id value
* <- id
 14:    ST 0, -4(5)	op: push left
* -> constant
 15:   LDC 0, 10(0)	load constant
* <- constant
 16:    ST 0, -5(5)	op: push left
 17:    LD 0, -4(5)	load right
 18:    LD 1, -5(5)	load left
 19:   SUB 0, 0, 1	op ==
 20:    ST 0, -3(5)	store value from math
* <- mathExp
* -> return
* looking up id: a
 22:    LD 0, -2(5)	load id value
* <- id
 23:    ST 0, -3(5)	op: push left
 24:    LD 7, -1(5)	return back to the caller
* <- return
 21:   JNE 0, 4(7)	if: jump to else
* looking up id: a
 26:   LDA 0, -2(5)	load id address
* <- id
 27:    ST 0, -4(5)	op: push left
* -> mathExp
* looking up id: a
 28:    LD 0, -2(5)	load id value
* <- id
 29:    ST 0, -6(5)	op: push left
* -> constant
 30:   LDC 0, 1(0)	load constant
* <- constant
 31:    ST 0, -7(5)	op: push left
 32:    LD 0, -6(5)	load right
 33:    LD 1, -7(5)	load left
 34:   ADD 0, 0, 1	op +
 35:    ST 0, -5(5)	store value from math
* <- mathExp
 36:    LD 0, -4(5)	load left
 37:    LD 1, -5(5)	load right
 38:    ST 1, 0(0)	store in ac1
 39:    ST 1, -3(5)	assign: store value
* -> return
* -> call of function: test
* looking up id: a
 40:    LD 0, -2(5)	load id value
* <- id
 41:    ST 0, -8(5)	op: push left
 42:    LD 0, -8(5)	load value to ac
 43:    ST 0, -10(5)	store arg value
 44:    ST 5, -8(5)	store current fp
 45:   LDA 5, -8(5)	push new frame
 46:   LDA 0, 1(7)	save return in ac
 47:   LDA 7, -36(7)	relative jump to function entry
 48:    LD 5, 0(5)	pop current frame
 49:    ST 0, -8(5)	store return
* <- call
 50:    LD 7, -1(5)	return back to the caller
* <- return
 25:   LDA 7, 25(7)	jump to end
* <- if
* <- compound statement
 51:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 40(7)	jump around func body
* <- funExp
* processing function: main
* jump around function body here
 53:    ST 0, -1(5)	save return address
* -> compound statement
* processing var: x
* <- varDec
* looking up id: x
 54:   LDA 0, -9(5)	load id address
* <- id
 55:    ST 0, -11(5)	op: push left
* -> constant
 56:   LDC 0, 1(0)	load constant
* <- constant
 57:    ST 0, -12(5)	op: push left
 58:    LD 0, -11(5)	load left
 59:    LD 1, -12(5)	load right
 60:    ST 1, 0(0)	store in ac1
 61:    ST 1, -10(5)	assign: store value
* -> call of function: output
* -> call of function: test
* looking up id: x
 62:    LD 0, -9(5)	load id value
* <- id
 63:    ST 0, -13(5)	op: push left
 64:    LD 0, -13(5)	load value to ac
 65:    ST 0, -15(5)	store arg value
 66:    ST 5, -13(5)	store current fp
 67:   LDA 5, -13(5)	push new frame
 68:   LDA 0, 1(7)	save return in ac
 69:   LDA 7, -58(7)	relative jump to function entry
 70:    LD 5, 0(5)	pop current frame
 71:    ST 0, -13(5)	store return
* <- call
 72:    LD 0, -13(5)	load value to ac
 73:    ST 0, -15(5)	store arg value
 74:    ST 5, -13(5)	store current fp
 75:   LDA 5, -13(5)	push new frame
 76:   LDA 0, 1(7)	save return in ac
 77:   LDA 7, -71(7)	relative jump to function entry
 78:    LD 5, 0(5)	pop current frame
 79:    ST 0, -13(5)	store return
* <- call
* <- compound statement
 80:    LD 7, -1(5)	return back to the caller
 52:   LDA 7, 28(7)	jump around func body
* <- funExp
 81:    ST 5, -14(5)	push ofp
 82:   LDA 5, -14(5)	push frame
 83:   LDA 0, 1(7)	load ac with ret ptr
 84:   LDA 7, -32(7) 	jump to main loc
 85:    LD 5, 0(5)	pop frame
* End of Execution
 86:  HALT 0, 0, 0	
