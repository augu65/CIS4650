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
* processing local var: x
* processing function: test
* jump around function body here
 12:    ST 0, -1(5)	save return address
* -> compound statement
 13:    LD 0, -3(5)	
 14:    ST 0, -5(5)	
 15:    LD 0, -5(5)	load value to ac
 16:    ST 0, -7(5)	store arg value
 17:    ST 5, -5(5)	store current fp
 18:   LDA 5, -5(5)	push new frame
 19:   LDA 0, 1(7)	save return in ac
 20:   LDA 7, -14(7)	relative jump to function entry
 21:    LD 5, 0(5)	pop current frame
 22:    ST 0, -5(5)	store return
 23:    LD 0, -2(5)	
 24:    ST 0, -6(5)	
 25:    LD 0, -6(5)	load value to ac
 26:    ST 0, -8(5)	store arg value
 27:    ST 5, -6(5)	store current fp
 28:   LDA 5, -6(5)	push new frame
 29:   LDA 0, 1(7)	save return in ac
 30:   LDA 7, -24(7)	relative jump to function entry
 31:    LD 5, 0(5)	pop current frame
 32:    ST 0, -6(5)	store return
 33:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 22(7)	jump forward to finale
* processing function: main
* jump around function body here
 35:    ST 0, -1(5)	save return address
* -> compound statement
* processing local var: o
* processing local var: u
* processing local var: v
 36:   LDA 0, -8(5)	
 37:    ST 0, -11(5)	
 38:   LDC 0, 7(0)	
 39:    ST 0, -12(5)	
 40:    LD 0, -11(5)	
 41:    LD 1, -12(5)	
 42:    ST 1, 0(0)	
 43:    ST 1, -10(5)	
 44:   LDA 0, -9(5)	
 45:    ST 0, -14(5)	
 46:   LDC 0, 2(0)	
 47:    ST 0, -15(5)	
 48:    LD 0, -14(5)	
 49:    LD 1, -15(5)	
 50:    ST 1, 0(0)	
 51:    ST 1, -13(5)	
 52:    LD 0, -8(5)	
 53:    ST 0, -16(5)	
 54:    LD 0, -9(5)	
 55:    ST 0, -17(5)	
 56:    LD 0, -17(5)	load value to ac
 57:    ST 0, -18(5)	store arg value
 58:    LD 0, -16(5)	load value to ac
 59:    ST 0, -19(5)	store arg value
 60:    ST 5, -16(5)	store current fp
 61:   LDA 5, -16(5)	push new frame
 62:   LDA 0, 1(7)	save return in ac
 63:   LDA 7, -52(7)	relative jump to function entry
 64:    LD 5, 0(5)	pop current frame
 65:    ST 0, -16(5)	store return
 66:    LD 7, -1(5)	return back to the caller
 34:   LDA 7, 32(7)	jump forward to finale
 67:    ST 5, -18(5)	push ofp
 68:   LDA 5, -18(5)	push frame
 69:   LDA 0, 1(7)	load ac with ret ptr
 70:   LDA 7, -36(7) 	jump to main loc
 71:    LD 5, 0(5)	pop frame
* End of Execution
 72:  HALT 0, 0, 0	
