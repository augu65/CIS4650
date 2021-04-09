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
* processing function: test
* jump around function body here
 12:    ST 0, -1(5)	save return address
 13:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 2(7)	jump forward to finale
* processing function: main
* jump around function body here
 15:    ST 0, -1(5)	save return address
* -> compound statement
* processing local var: x
 16:    ST 5, -3(5)	store current fp
 17:   LDA 5, -3(5)	push new frame
 18:   LDA 0, 1(7)	save return in ac
 19:   LDA 7, -16(7)	relative jump to function entry
 20:    LD 5, 0(5)	pop current frame
 21:    ST 0, -3(5)	store return
 22:   LDA 0, -2(5)	
 23:    ST 0, -4(5)	
 24:   LDC 0, 1(0)	
 25:    ST 0, -5(5)	
 26:    LD 0, -4(5)	
 27:    LD 1, -5(5)	
 28:    ST 1, 0(0)	
 29:    ST 1, -3(5)	
 30:   LDA 0, -2(5)	
 31:    ST 0, -7(5)	
 32:    LD 0, -2(5)	
 33:    ST 0, -9(5)	
 34:   LDC 0, 1(0)	
 35:    ST 0, -10(5)	
 36:    LD 0, -9(5)	
 37:    LD 1, -10(5)	
 38:   MUL 0, 0, 1	
 39:    ST 0, -8(5)	
 40:    LD 0, -7(5)	
 41:    LD 1, -8(5)	
 42:    ST 1, 0(0)	
 43:    ST 1, -6(5)	
 44:    ST 5, -11(5)	store current fp
 45:   LDA 5, -11(5)	push new frame
 46:   LDA 0, 1(7)	save return in ac
 47:   LDA 7, -36(7)	relative jump to function entry
 48:    LD 5, 0(5)	pop current frame
 49:    ST 0, -11(5)	store return
 50:    LD 7, -1(5)	return back to the caller
 14:   LDA 7, 36(7)	jump forward to finale
 51:    ST 5, -11(5)	push ofp
 52:   LDA 5, -11(5)	push frame
 53:   LDA 0, 1(7)	load ac with ret ptr
 54:   LDA 7, -40(7) 	jump to main loc
 55:    LD 5, 0(5)	pop frame
* End of Execution
 56:  HALT 0, 0, 0	
