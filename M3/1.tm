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
* processing var: x
* <- varDec
* processing function: test
* jump around function body here
 12:    ST 0, -1(5)	save return address
* -> compound statement
* -> call of function: output
* looking up id: a
 13:    LD 0, -3(5)	load id value
* <- id
 14:    ST 0, -5(5)	op: push left
 15:    LD 0, -5(5)	load value to ac
 16:    ST 0, -7(5)	store arg value
 17:    ST 5, -5(5)	store current fp
 18:   LDA 5, -5(5)	push new frame
 19:   LDA 0, 1(7)	save return in ac
 20:   LDA 7, -14(7)	relative jump to function entry
 21:    LD 5, 0(5)	pop current frame
 22:    ST 0, -5(5)	store return
* <- call
* -> return
* -> constant
 23:   LDC 0, 5(0)	load constant
* <- constant
 24:    ST 0, -6(5)	op: push left
 25:    LD 7, -1(5)	return back to the caller
* <- return
* -> call of function: output
* looking up id: b
 26:    LD 0, -2(5)	load id value
* <- id
 27:    ST 0, -7(5)	op: push left
 28:    LD 0, -7(5)	load value to ac
 29:    ST 0, -9(5)	store arg value
 30:    ST 5, -7(5)	store current fp
 31:   LDA 5, -7(5)	push new frame
 32:   LDA 0, 1(7)	save return in ac
 33:   LDA 7, -27(7)	relative jump to function entry
 34:    LD 5, 0(5)	pop current frame
 35:    ST 0, -7(5)	store return
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
* <- varDec
* processing var: u
* <- varDec
* processing var: v
* <- varDec
* looking up id: u
 39:   LDA 0, -9(5)	load id address
* <- id
 40:    ST 0, -12(5)	op: push left
* -> constant
 41:   LDC 0, 7(0)	load constant
* <- constant
 42:    ST 0, -13(5)	op: push left
 43:    LD 0, -12(5)	load left
 44:    LD 1, -13(5)	load right
 45:    ST 1, 0(0)	store in ac1
 46:    ST 1, -11(5)	assign: store value
* looking up id: v
 47:   LDA 0, -10(5)	load id address
* <- id
 48:    ST 0, -15(5)	op: push left
* -> constant
 49:   LDC 0, 2(0)	load constant
* <- constant
 50:    ST 0, -16(5)	op: push left
 51:    LD 0, -15(5)	load left
 52:    LD 1, -16(5)	load right
 53:    ST 1, 0(0)	store in ac1
 54:    ST 1, -14(5)	assign: store value
* looking up id: v
 55:   LDA 0, -10(5)	load id address
* <- id
 56:    ST 0, -18(5)	op: push left
* -> call of function: test
* looking up id: u
 57:    LD 0, -9(5)	load id value
* <- id
 58:    ST 0, -19(5)	op: push left
* looking up id: v
 59:    LD 0, -10(5)	load id value
* <- id
 60:    ST 0, -20(5)	op: push left
 61:    LD 0, -20(5)	load value to ac
 62:    ST 0, -21(5)	store arg value
 63:    LD 0, -19(5)	load value to ac
 64:    ST 0, -22(5)	store arg value
 65:    ST 5, -19(5)	store current fp
 66:   LDA 5, -19(5)	push new frame
 67:   LDA 0, 1(7)	save return in ac
 68:   LDA 7, -57(7)	relative jump to function entry
 69:    LD 5, 0(5)	pop current frame
 70:    ST 0, -19(5)	store return
* <- call
 71:    LD 0, -18(5)	load left
 72:    LD 1, -19(5)	load right
 73:    ST 1, 0(0)	store in ac1
 74:    ST 1, -17(5)	assign: store value
* -> call of function: output
* looking up id: v
 75:    LD 0, -10(5)	load id value
* <- id
 76:    ST 0, -21(5)	op: push left
 77:    LD 0, -21(5)	load value to ac
 78:    ST 0, -23(5)	store arg value
 79:    ST 5, -21(5)	store current fp
 80:   LDA 5, -21(5)	push new frame
 81:   LDA 0, 1(7)	save return in ac
 82:   LDA 7, -76(7)	relative jump to function entry
 83:    LD 5, 0(5)	pop current frame
 84:    ST 0, -21(5)	store return
* <- call
* <- compound statement
 85:    LD 7, -1(5)	return back to the caller
 37:   LDA 7, 48(7)	jump around func body
* <- funExp
 86:    ST 5, -22(5)	push ofp
 87:   LDA 5, -22(5)	push frame
 88:   LDA 0, 1(7)	load ac with ret ptr
 89:   LDA 7, -52(7) 	jump to main loc
 90:    LD 5, 0(5)	pop frame
* End of Execution
 91:  HALT 0, 0, 0	
