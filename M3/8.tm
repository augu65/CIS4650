* C-Minus Compilation to TM Code
* File: 8.tm
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
* processing function: main
* jump around function body here
 14:    ST 0, -1(5)	save return address
* -> compound statement
* looking up id: j
 15:   LDA 0, -2(5)	load id address
* <- id
 16:    ST 0, -14(5)	op: push left
* -> mathExp
* looking up id: j
 17:    LD 0, -2(5)	load id value
* <- id
 18:    ST 0, -16(5)	op: push left
* -> constant
 19:   LDC 0, 0(0)	load constant
* <- constant
 20:    ST 0, -17(5)	op: push left
 21:    LD 0, -16(5)	load right
 22:    LD 1, -17(5)	load left
 23:   ADD 0, 0, 1	op +
 24:    ST 0, -15(5)	store value from math
* <- mathExp
 25:    LD 0, -14(5)	load left
 26:    LD 1, -15(5)	load right
 27:    ST 1, 0(0)	store in ac1
 28:    ST 1, -13(5)	assign: store value
* looking up id: t
 29:   LDA 0, -11(5)	load id address
* <- id
 30:    ST 0, -19(5)	op: push left
* -> mathExp
* looking up id: t
 31:    LD 0, -11(5)	load id value
* <- id
 32:    ST 0, -21(5)	op: push left
 33:    LD 0, -23(5)	load left
 34:    LD 1, -24(5)	load right
 35:    ST 1, 0(0)	store in ac1
 36:    ST 1, -22(5)	assign: store value
 37:    LD 0, -21(5)	load right
 38:    LD 1, -22(5)	load left
 39:   MUL 0, 0, 1	op *
 40:    ST 0, -20(5)	store value from math
* <- mathExp
 41:    LD 0, -19(5)	load left
 42:    LD 1, -20(5)	load right
 43:    ST 1, 0(0)	store in ac1
 44:    ST 1, -18(5)	assign: store value
* <- compound statement
 45:    LD 7, -1(5)	return back to the caller
 13:   LDA 7, 32(7)	jump around func body
* <- funExp
 46:    ST 5, -22(5)	push ofp
 47:   LDA 5, -22(5)	push frame
 48:   LDA 0, 1(7)	load ac with ret ptr
 49:   LDA 7, -36(7) 	jump to main loc
 50:    LD 5, 0(5)	pop frame
* End of Execution
 51:  HALT 0, 0, 0	
