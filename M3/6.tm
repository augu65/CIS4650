* C-Minus Compilation to TM Code
* File: 6.tm
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
* processing var: a
* -> constant
 11:   LDC 0, 8(0)	load constant
* <- constant
 12:    ST 0, -2(5)	op: push left
* <- varDec
* processing function: thing
* jump around function body here
 14:    ST 0, -1(5)	save return address
* -> compound statement
* processing var: y
* <- varDec
* -> return
 15:    LD 7, -1(5)	return back to the caller
* <- return
* <- compound statement
 16:    LD 7, -1(5)	return back to the caller
 13:   LDA 7, 3(7)	jump around func body
* <- funExp
* processing function: main
* jump around function body here
 18:    ST 0, -1(5)	save return address
* -> compound statement
* processing var: z
* <- varDec
* -> constant
 19:   LDC 0, 2(0)	load constant
* <- constant
 20:    ST 0, -15(5)	op: push left
* looking up id: a
* -> array bounds check
* <- array bounds check
 21:   LDA 0, -4(5)	load id address
* <- id
 22:    ST 0, -15(5)	op: push left
 23:    LD 0, -15(5)	load left
 24:    LD 1, -16(5)	load right
 25:    ST 1, 0(0)	store in ac1
 26:    ST 1, -14(5)	assign: store value
* looking up id: z
 27:   LDA 0, -13(5)	load id address
* <- id
 28:    ST 0, -17(5)	op: push left
* looking up id: a
* -> array bounds check
 29:   LDC 0, 8(0)	load constant
 30:    LD 1, -17(5)	load id value
 31:   SUB 0, 1, 0	op -
 32:   JGT 0, 1(7)	bouns check: jump
 33:  HALT 0, 0, 0	out of bounds
* <- array bounds check
 34:   LDA 0, 15(5)	load id address
* <- id
 35:    ST 0, -17(5)	op: push left
* -> call of function: thing
 36:    ST 5, -18(5)	store current fp
 37:   LDA 5, -18(5)	push new frame
 38:   LDA 0, 1(7)	save return in ac
 39:   LDA 7, -26(7)	relative jump to function entry
 40:    LD 5, 0(5)	pop current frame
 41:    ST 0, -18(5)	store return
* <- call
 42:    LD 0, -17(5)	load left
 43:    LD 1, -18(5)	load right
 44:    ST 1, 0(0)	store in ac1
 45:    ST 1, -16(5)	assign: store value
* -> return
* -> call of function: thing
 46:    ST 5, -18(5)	store current fp
 47:   LDA 5, -18(5)	push new frame
 48:   LDA 0, 1(7)	save return in ac
 49:   LDA 7, -36(7)	relative jump to function entry
 50:    LD 5, 0(5)	pop current frame
 51:    ST 0, -18(5)	store return
* <- call
 52:    LD 7, -1(5)	return back to the caller
* <- return
* <- compound statement
 53:    LD 7, -1(5)	return back to the caller
 17:   LDA 7, 36(7)	jump around func body
* <- funExp
 54:    ST 5, -18(5)	push ofp
 55:   LDA 5, -18(5)	push frame
 56:   LDA 0, 1(7)	load ac with ret ptr
 57:   LDA 7, -40(7) 	jump to main loc
 58:    LD 5, 0(5)	pop frame
* End of Execution
 59:  HALT 0, 0, 0	
