* C-Minus Compilation to TM Code
* File: gcd.tm
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
* processing var: y
* <- varDec
* processing function: gcd
* jump around function body here
 12:    ST 0, -1(5)	save return address
* -> compound statement
* -> if
* -> mathExp
* looking up id: v
 13:    LD 0, -2(5)	load id value
* <- id
 14:    ST 0, -6(5)	op: push left
* -> constant
 15:   LDC 0, 0(0)	load constant
* <- constant
 16:    ST 0, -7(5)	op: push left
 17:    LD 0, -6(5)	load right
 18:    LD 1, -7(5)	load left
 19:   SUB 0, 0, 1	op ==
 20:    ST 0, -5(5)	store value from math
* <- mathExp
* -> return
* looking up id: u
 22:    LD 0, -3(5)	load id value
* <- id
 23:    ST 0, -5(5)	op: push left
 24:    LD 7, -1(5)	return back to the caller
* <- return
 21:   JNE 0, 4(7)	if: jump to else
* -> return
* -> call of function: gcd
* looking up id: v
 26:    LD 0, -2(5)	load id value
* <- id
 27:    ST 0, -5(5)	op: push left
* -> mathExp
* looking up id: u
 28:    LD 0, -3(5)	load id value
* <- id
 29:    ST 0, -7(5)	op: push left
* -> mathExp
* -> mathExp
* looking up id: u
 30:    LD 0, -3(5)	load id value
* <- id
 31:    ST 0, -10(5)	op: push left
* looking up id: v
 32:    LD 0, -2(5)	load id value
* <- id
 33:    ST 0, -11(5)	op: push left
 34:    LD 0, -10(5)	load right
 35:    LD 1, -11(5)	load left
 36:   DIV 0, 0, 1	op /
 37:    ST 0, -9(5)	store value from math
* <- mathExp
* looking up id: v
 38:    LD 0, -2(5)	load id value
* <- id
 39:    ST 0, -10(5)	op: push left
 40:    LD 0, -9(5)	load right
 41:    LD 1, -10(5)	load left
 42:   MUL 0, 0, 1	op *
 43:    ST 0, -8(5)	store value from math
* <- mathExp
 44:    LD 0, -7(5)	load right
 45:    LD 1, -8(5)	load left
 46:   SUB 0, 0, 1	op -
 47:    ST 0, -6(5)	store value from math
* <- mathExp
 48:    LD 0, -9(5)	load value to ac
 49:    ST 0, -7(5)	store arg value
 50:    LD 0, -5(5)	load value to ac
 51:    ST 0, -8(5)	store arg value
 52:    ST 5, -5(5)	store current fp
 53:   LDA 5, -5(5)	push new frame
 54:   LDA 0, 1(7)	save return in ac
 55:   LDA 7, -44(7)	relative jump to function entry
 56:    LD 5, 0(5)	pop current frame
 57:    ST 0, -5(5)	store return
* <- call
 58:    LD 7, -1(5)	return back to the caller
* <- return
 25:   LDA 7, 33(7)	jump to end
* <- if
* <- compound statement
 59:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 48(7)	jump around func body
* <- funExp
* processing function: main
* jump around function body here
 61:    ST 0, -1(5)	save return address
* -> compound statement
* processing var: x
* <- varDec
* looking up id: x
 62:   LDA 0, -11(5)	load id address
* <- id
 63:    ST 0, -13(5)	op: push left
* -> call of function: input
 64:    ST 5, -14(5)	store current fp
 65:   LDA 5, -14(5)	push new frame
 66:   LDA 0, 1(7)	save return in ac
 67:   LDA 7, -64(7)	relative jump to function entry
 68:    LD 5, 0(5)	pop current frame
 69:    ST 0, -14(5)	store return
* <- call
 70:    LD 0, -13(5)	load left
 71:    LD 1, -14(5)	load right
 72:    ST 1, 0(0)	store in ac1
 73:    ST 1, -12(5)	assign: store value
* looking up id: y
 74:   LDA 0, -2(5)	load id address
* <- id
 75:    ST 0, -15(5)	op: push left
* -> constant
 76:   LDC 0, 10(0)	load constant
* <- constant
 77:    ST 0, -16(5)	op: push left
 78:    LD 0, -15(5)	load left
 79:    LD 1, -16(5)	load right
 80:    ST 1, 0(0)	store in ac1
 81:    ST 1, -14(5)	assign: store value
* -> call of function: output
* -> call of function: gcd
* looking up id: x
 82:    LD 0, -11(5)	load id value
* <- id
 83:    ST 0, -17(5)	op: push left
* looking up id: y
 84:    LD 0, -2(5)	load id value
* <- id
 85:    ST 0, -18(5)	op: push left
 86:    LD 0, -18(5)	load value to ac
 87:    ST 0, -19(5)	store arg value
 88:    LD 0, -17(5)	load value to ac
 89:    ST 0, -20(5)	store arg value
 90:    ST 5, -17(5)	store current fp
 91:   LDA 5, -17(5)	push new frame
 92:   LDA 0, 1(7)	save return in ac
 93:   LDA 7, -82(7)	relative jump to function entry
 94:    LD 5, 0(5)	pop current frame
 95:    ST 0, -17(5)	store return
* <- call
 96:    LD 0, -17(5)	load value to ac
 97:    ST 0, -19(5)	store arg value
 98:    LD 0, -18(5)	load value to ac
 99:    ST 0, -20(5)	store arg value
100:    LD 0, -17(5)	load value to ac
101:    ST 0, -21(5)	store arg value
102:    ST 5, -17(5)	store current fp
103:   LDA 5, -17(5)	push new frame
104:   LDA 0, 1(7)	save return in ac
105:   LDA 7, -99(7)	relative jump to function entry
106:    LD 5, 0(5)	pop current frame
107:    ST 0, -17(5)	store return
* <- call
* <- compound statement
108:    LD 7, -1(5)	return back to the caller
 60:   LDA 7, 48(7)	jump around func body
* <- funExp
109:    ST 5, -19(5)	push ofp
110:   LDA 5, -19(5)	push frame
111:   LDA 0, 1(7)	load ac with ret ptr
112:   LDA 7, -52(7) 	jump to main loc
113:    LD 5, 0(5)	pop frame
* End of Execution
114:  HALT 0, 0, 0	