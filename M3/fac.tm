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
 20:    LD 0, -5(5)	
 21:    LD 1, -6(5)	
 22:    ST 1, 0(0)	
 23:    ST 1, -4(5)	
 24:   LDA 0, -3(5)	
 25:    ST 0, -7(5)	
 26:   LDC 0, 1(0)	
 27:    ST 0, -8(5)	
 28:    LD 0, -7(5)	
 29:    LD 1, -8(5)	
 30:    ST 1, 0(0)	
 31:    ST 1, -6(5)	
 32:    LD 0, -2(5)	
 33:    ST 0, -10(5)	
 34:   LDC 0, 1(0)	
 35:    ST 0, -11(5)	
 36:    LD 0, -10(5)	
 37:    LD 1, -11(5)	
 38:   SUB 0, 0, 1	
 39:    ST 0, -9(5)	
 41:   LDA 0, -3(5)	
 42:    ST 0, -10(5)	
 43:    LD 0, -3(5)	
 44:    ST 0, -12(5)	
 45:    LD 0, -2(5)	
 46:    ST 0, -13(5)	
 47:    LD 0, -12(5)	
 48:    LD 1, -13(5)	
 49:   MUL 0, 0, 1	
 50:    ST 0, -11(5)	
 51:    LD 0, -10(5)	
 52:    LD 1, -11(5)	
 53:    ST 1, 0(0)	
 54:    ST 1, -9(5)	
 55:   LDA 0, -2(5)	
 56:    ST 0, -15(5)	
 57:    LD 0, -2(5)	
 58:    ST 0, -17(5)	
 59:   LDC 0, 1(0)	
 60:    ST 0, -18(5)	
 61:    LD 0, -17(5)	
 62:    LD 1, -18(5)	
 63:   SUB 0, 0, 1	
 64:    ST 0, -16(5)	
 65:    LD 0, -15(5)	
 66:    LD 1, -16(5)	
 67:    ST 1, 0(0)	
 68:    ST 1, -14(5)	
 69:   LDA 7, -38(7)	jump to while
 40:   JLT 0, 29(7)	test condition
 70:    LD 0, -3(5)	
 71:    ST 0, -19(5)	
 72:    LD 0, -19(5)	load valaue to ac
 73:    ST 0, -21(5)	store arg value
 74:    ST 5, -19(5)	store current fp
 75:   LDA 5, -19(5)	push new frame
 76:   LDA 0, 1(7)	save return in ac
 77:   LDA 7, -71(7)	relative jump to function entry
 78:    LD 5, 0(5)	pop current frame
 79:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 68(7)	jump forward to finale
 80:    ST 5, -20(5)	push ofp
 81:   LDA 5, -20(5)	push frame
 82:   LDA 0, 1(7)	load ac with ret ptr
 83:   LDA 7, -72(7) 	jump to main loc
 84:    LD 5, 0(5)	pop frame
* End of Execution
 85:  HALT 0, 0, 0	
