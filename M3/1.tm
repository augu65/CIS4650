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
 15:   LDC 0, 2(0)	
 16:    ST 0, -5(5)	
 17:    LD 0, -4(5)	
 18:    LD 1, -5(5)	
 19:    ST 1, 0(0)	
 20:    ST 1, -3(5)	
 21:   LDA 0, -2(5)	
 22:    ST 0, -6(5)	
 23:    LD 0, -2(5)	
 24:    ST 0, -8(5)	
 25:   LDC 0, 3(0)	
 26:    ST 0, -9(5)	
 27:    LD 0, -8(5)	
 28:    LD 1, -9(5)	
 29:   ADD 0, 0, 1	
 30:    ST 0, -7(5)	
 31:    LD 0, -6(5)	
 32:    LD 1, -7(5)	
 33:    ST 1, 0(0)	
 34:    ST 1, -5(5)	
 35:    LD 0, -2(5)	
 36:    ST 0, -10(5)	
 37:   LDC 0, 3(0)	
 38:    ST 0, -11(5)	
 39:    LD 0, -10(5)	
 40:    LD 1, -11(5)	
 41:   SUB 0, 0, 1	
 42:    ST 0, -9(5)	
* processing local var: j
 44:    LD 0, -2(5)	
 45:    ST 0, -11(5)	
 46:   LDC 0, 4(0)	
 47:    ST 0, -12(5)	
 48:    LD 0, -11(5)	
 49:    LD 1, -12(5)	
 50:   SUB 0, 0, 1	
 51:    ST 0, -10(5)	
 53:   LDA 0, -9(5)	
 54:    ST 0, -11(5)	
 55:    LD 0, -9(5)	
 56:    ST 0, -13(5)	
 57:   LDC 0, 1(0)	
 58:    ST 0, -14(5)	
 59:    LD 0, -13(5)	
 60:    LD 1, -14(5)	
 61:   ADD 0, 0, 1	
 62:    ST 0, -12(5)	
 63:    LD 0, -11(5)	
 64:    LD 1, -12(5)	
 65:    ST 1, 0(0)	
 66:    ST 1, -10(5)	
 52:   JEQ 0, 67(7)	
 67:   LDA 7, 53(7)	
 43:   JGT 0, 68(7)	
 68:   LDA 7, 69(7)	
 69:   LDA 0, -2(5)	
 70:    ST 0, -15(5)	
 71:   LDC 0, 2(0)	
 72:    ST 0, -16(5)	
 73:    LD 0, -15(5)	
 74:    LD 1, -16(5)	
 75:    ST 1, 0(0)	
 76:    ST 1, -14(5)	
 77:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 66(7)	jump forward to finale
 78:    ST 5, -16(5)	push ofp
 79:   LDA 5, -16(5)	push frame
 80:   LDA 0, 1(7)	load ac with ret ptr
 81:   LDA 7, -70(7) 	jump to main loc
 82:    LD 5, 0(5)	pop frame
* End of Execution
 83:  HALT 0, 0, 0	
