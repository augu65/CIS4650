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
* -> call of function: output
* looking up id: u
 13:    LD 0, -3(5)	load id value
* <- id
 14:    ST 0, -5(5)	op: push left
 15:    LD 0, -5(5)	load value to ac
 16:    ST 0, -7(5)	store arg value
 17:    ST 5, -5(5)	store current fp
 18:   LDA 5, -5(5)	push new frame
 19:   LDA 0, 1(7)	save return in ac
 20:   LDA 7, -14(7)	relative jump to function entry
 21:    LD 5, 0(5)	pop current frame
 22:    ST 0, -5(5)	store return
* <- call
* -> call of function: output
* looking up id: v
 23:    LD 0, -2(5)	load id value
* <- id
 24:    ST 0, -6(5)	op: push left
 25:    LD 0, -6(5)	load value to ac
 26:    ST 0, -8(5)	store arg value
 27:    ST 5, -6(5)	store current fp
 28:   LDA 5, -6(5)	push new frame
 29:   LDA 0, 1(7)	save return in ac
 30:   LDA 7, -24(7)	relative jump to function entry
 31:    LD 5, 0(5)	pop current frame
 32:    ST 0, -6(5)	store return
* <- call
* -> if
* -> mathExp
* looking up id: v
 33:    LD 0, -2(5)	load id value
* <- id
 34:    ST 0, -8(5)	op: push left
* -> constant
 35:   LDC 0, 0(0)	load constant
* <- constant
 36:    ST 0, -9(5)	op: push left
 37:    LD 0, -8(5)	load right
 38:    LD 1, -9(5)	load left
 39:   SUB 0, 0, 1	op ==
 40:    ST 0, -7(5)	store value from math
* <- mathExp
* -> return
* looking up id: u
 42:    LD 0, -3(5)	load id value
* <- id
 43:    ST 0, -7(5)	op: push left
 44:    LD 7, -1(5)	return back to the caller
* <- return
 41:   JNE 0, 4(7)	if: jump to else
* processing var: w
* <- varDec
* looking up id: w
 46:   LDA 0, -7(5)	load id address
* <- id
 47:    ST 0, -9(5)	op: push left
* -> mathExp
* looking up id: u
 48:    LD 0, -3(5)	load id value
* <- id
 49:    ST 0, -11(5)	op: push left
* -> mathExp
* -> mathExp
* looking up id: u
 50:    LD 0, -3(5)	load id value
* <- id
 51:    ST 0, -14(5)	op: push left
* looking up id: v
 52:    LD 0, -2(5)	load id value
* <- id
 53:    ST 0, -15(5)	op: push left
 54:    LD 0, -14(5)	load right
 55:    LD 1, -15(5)	load left
 56:   DIV 0, 0, 1	op /
 57:    ST 0, -13(5)	store value from math
* <- mathExp
* looking up id: v
 58:    LD 0, -2(5)	load id value
* <- id
 59:    ST 0, -14(5)	op: push left
 60:    LD 0, -13(5)	load right
 61:    LD 1, -14(5)	load left
 62:   MUL 0, 0, 1	op *
 63:    ST 0, -12(5)	store value from math
* <- mathExp
 64:    LD 0, -11(5)	load right
 65:    LD 1, -12(5)	load left
 66:   SUB 0, 0, 1	op -
 67:    ST 0, -10(5)	store value from math
* <- mathExp
 68:    LD 0, -9(5)	load left
 69:    LD 1, -10(5)	load right
 70:    ST 1, 0(0)	store in ac1
 71:    ST 1, -8(5)	assign: store value
* -> return
* -> call of function: gcd
* looking up id: v
 72:    LD 0, -2(5)	load id value
* <- id
 73:    ST 0, -15(5)	op: push left
* looking up id: w
 74:    LD 0, -7(5)	load id value
* <- id
 75:    ST 0, -16(5)	op: push left
 76:    LD 0, -16(5)	load value to ac
 77:    ST 0, -17(5)	store arg value
 78:    LD 0, -15(5)	load value to ac
 79:    ST 0, -18(5)	store arg value
 80:    ST 5, -15(5)	store current fp
 81:   LDA 5, -15(5)	push new frame
 82:   LDA 0, 1(7)	save return in ac
 83:   LDA 7, -72(7)	relative jump to function entry
 84:    LD 5, 0(5)	pop current frame
 85:    ST 0, -15(5)	store return
* <- call
 86:    LD 7, -1(5)	return back to the caller
* <- return
 45:   LDA 7, 41(7)	jump to end
* <- if
* <- compound statement
 87:    LD 7, -1(5)	return back to the caller
 11:   LDA 7, 76(7)	jump around func body
* <- funExp
* processing function: main
* jump around function body here
 89:    ST 0, -1(5)	save return address
* -> compound statement
* processing var: x
* <- varDec
* looking up id: x
 90:   LDA 0, -17(5)	load id address
* <- id
 91:    ST 0, -19(5)	op: push left
* -> call of function: input
 92:    ST 5, -20(5)	store current fp
 93:   LDA 5, -20(5)	push new frame
 94:   LDA 0, 1(7)	save return in ac
 95:   LDA 7, -92(7)	relative jump to function entry
 96:    LD 5, 0(5)	pop current frame
 97:    ST 0, -20(5)	store return
* <- call
 98:    LD 0, -19(5)	load left
 99:    LD 1, -20(5)	load right
100:    ST 1, 0(0)	store in ac1
101:    ST 1, -18(5)	assign: store value
* looking up id: y
102:   LDA 0, -2(5)	load id address
* <- id
103:    ST 0, -21(5)	op: push left
* -> constant
104:   LDC 0, 10(0)	load constant
* <- constant
105:    ST 0, -22(5)	op: push left
106:    LD 0, -21(5)	load left
107:    LD 1, -22(5)	load right
108:    ST 1, 0(0)	store in ac1
109:    ST 1, -20(5)	assign: store value
* -> call of function: output
* -> call of function: gcd
* looking up id: x
110:    LD 0, -17(5)	load id value
* <- id
111:    ST 0, -23(5)	op: push left
* looking up id: y
112:    LD 0, -2(5)	load id value
* <- id
113:    ST 0, -24(5)	op: push left
114:    LD 0, -24(5)	load value to ac
115:    ST 0, -25(5)	store arg value
116:    LD 0, -23(5)	load value to ac
117:    ST 0, -26(5)	store arg value
118:    ST 5, -23(5)	store current fp
119:   LDA 5, -23(5)	push new frame
120:   LDA 0, 1(7)	save return in ac
121:   LDA 7, -110(7)	relative jump to function entry
122:    LD 5, 0(5)	pop current frame
123:    ST 0, -23(5)	store return
* <- call
124:    LD 0, -23(5)	load value to ac
125:    ST 0, -25(5)	store arg value
126:    ST 5, -23(5)	store current fp
127:   LDA 5, -23(5)	push new frame
128:   LDA 0, 1(7)	save return in ac
129:   LDA 7, -123(7)	relative jump to function entry
130:    LD 5, 0(5)	pop current frame
131:    ST 0, -23(5)	store return
* <- call
* <- compound statement
132:    LD 7, -1(5)	return back to the caller
 88:   LDA 7, 44(7)	jump around func body
* <- funExp
133:    ST 5, -25(5)	push ofp
134:   LDA 5, -25(5)	push frame
135:   LDA 0, 1(7)	load ac with ret ptr
136:   LDA 7, -48(7) 	jump to main loc
137:    LD 5, 0(5)	pop frame
* End of Execution
138:  HALT 0, 0, 0	
