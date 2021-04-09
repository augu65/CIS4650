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
* processing local var: o
 13:   LDA 0, -5(5)	
 14:    ST 0, -7(5)	
 15:    ST 5, -8(5)	store current fp
 16:   LDA 5, -8(5)	push new frame
 17:   LDA 0, 1(7)	save return in ac
 18:   LDA 7, -15(7)	relative jump to function entry
 19:    LD 5, 0(5)	pop current frame
 20:    LD 0, -7(5)	
 21:    LD 1, -8(5)	
 22:    ST 1, 0(0)	
 23:    ST 1, -6(5)	
 24:    LD 0, -5(5)	
 25:    ST 0, -8(5)	
 26:    LD 0, -8(5)	load valaue to ac
 27:    ST 0, -10(5)	store arg value
 28:    ST 5, -8(5)	store current fp
 29:   LDA 5, -8(5)	push new frame
 30:   LDA 0, 1(7)	save return in ac
 31:   LDA 7, -25(7)	relative jump to function entry
 32:    LD 5, 0(5)	pop current frame
 33:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 22(7)	jump forward to finale
 34:    ST 5, -9(5)	push ofp
 35:   LDA 5, -9(5)	push frame
 36:   LDA 0, 1(7)	load ac with ret ptr
 37:   LDA 7, -26(7) 	jump to main loc
 38:    LD 5, 0(5)	pop frame
* End of Execution
 39:  HALT 0, 0, 0	
