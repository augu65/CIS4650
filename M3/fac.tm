* C-Minus Compilation to TM Code
* File: fac.tm
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
* processing local var: x
* processing local var: fac
 13:   LDA 0, -2(5)	
 14:    ST 0, -5(5)	
 15:    ST 5, -6(5)	store current fp
 16:   LDA 5, -6(5)	push new frame
 17:   LDA 0, 1(7)	save return in ac
 18:   LDA 7, -15(7)	relative jump to function entry
 19:    LD 5, 0(5)	pop current frame
 20:    ST 0, -6(5)	store return
 21:    LD 0, -5(5)	
 22:    LD 1, -6(5)	
 23:    ST 1, 0(0)	
 24:    ST 1, -4(5)	
 25:   LDA 0, -3(5)	
 26:    ST 0, -7(5)	
 27:   LDC 0, 1(0)	
 28:    ST 0, -8(5)	
 29:    LD 0, -7(5)	
 30:    LD 1, -8(5)	
 31:    ST 1, 0(0)	
 32:    ST 1, -6(5)	
 33:    LD 0, -2(5)	
 34:    ST 0, -10(5)	
 35:   LDC 0, 1(0)	
 36:    ST 0, -11(5)	
 37:    LD 0, -10(5)	
 38:    LD 1, -11(5)	
 39:   SUB 0, 0, 1	
 40:    ST 0, -9(5)	store
 42:   LDA 0, -3(5)	
 43:    ST 0, -10(5)	
 44:    LD 0, -3(5)	
 45:    ST 0, -12(5)	
 46:    LD 0, -2(5)	
 47:    ST 0, -13(5)	
 48:    LD 0, -12(5)	
 49:    LD 1, -13(5)	
 50:   MUL 0, 0, 1	
 51:    ST 0, -11(5)	store
 52:    LD 0, -10(5)	
 53:    LD 1, -11(5)	
 54:    ST 1, 0(0)	
 55:    ST 1, -9(5)	
 56:   LDA 0, -2(5)	
 57:    ST 0, -15(5)	
 58:    LD 0, -2(5)	
 59:    ST 0, -17(5)	
 60:   LDC 0, 1(0)	
 61:    ST 0, -18(5)	
 62:    LD 0, -17(5)	
 63:    LD 1, -18(5)	
 64:   SUB 0, 0, 1	
 65:    ST 0, -16(5)	store
 66:    LD 0, -15(5)	
 67:    LD 1, -16(5)	
 68:    ST 1, 0(0)	
 69:    ST 1, -14(5)	
 70:   LDA 7, -38(7)	jump to while
 41:   JLT 0, 29(7)	test condition
 71:    LD 0, -3(5)	
 72:    ST 0, -19(5)	
 73:    LD 0, -19(5)	load value to ac
 74:    ST 0, -21(5)	store arg value
 75:    ST 5, -19(5)	store current fp
 76:   LDA 5, -19(5)	push new frame
 77:   LDA 0, 1(7)	save return in ac
 78:   LDA 7, -72(7)	relative jump to function entry
 79:    LD 5, 0(5)	pop current frame
 80:    ST 0, -19(5)	store return
 81:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 70(7)	jump forward to finale
 82:    ST 5, -20(5)	push ofp
 83:   LDA 5, -20(5)	push frame
 84:   LDA 0, 1(7)	load ac with ret ptr
 85:   LDA 7, -74(7) 	jump to main loc
 86:    LD 5, 0(5)	pop frame
* End of Execution
 87:  HALT 0, 0, 0	
