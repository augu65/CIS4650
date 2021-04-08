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
  8:    LD 0, 0(0)	load output value
  9:   OUT 7, 0, 5	output
 10:    LD 5, 0(6)	return to caller
  3:   LDA 7, 7(7) 	jump around i/o code
* End of standard prelude.
* processing function: main
* jump around fucntion body here
 12:    ST 0, -1(5)	save return address
* -> compound statement
* processing local var: x
 13:   LDA 0, -2(5)	
 14:    ST 0, -4(5)	
 15:    LD 0, -2(5)	
 16:    ST 0, -6(5)	
 17:   LDC 0, 3(0)	
 18:    ST 0, -7(5)	
 19:    LD 0, -6(5)	
 20:    LD 1, -7(5)	
 21:   ADD 0, 0, 1	
 22:    ST 0, -5(5)	
 23:    LD 0, -4(5)	
 24:    LD 1, -5(5)	
 25:    ST 1, 0(0)	
 26:    ST 1, -3(5)	
 27:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 2(7)	jump forward to finale
 28:    ST 5, -7(5)	push ofp
 29:   LDA 5, -7(5)	push frame
 30:   LDA 0, 1(7)	load ac with ret ptr
 31:   LDA 7, -32(7) 	jump to main loc
 32:    LD 5, 0(5)	pop frame
* End of Execution
 33:  HALT 0, 0, 0	
