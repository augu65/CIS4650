* Standard prelude:
  0:	 LD 6, 0(0)	load gp with maxaddress
  1:	 LDA 5, 0(6)	copy to gp to fp
  2:	 ST 0, 0(0)	clear location 0
* Jump around i/o routines here
* code for input routine
  3:	 ST 0, -1(5)	store return
  4:	 IN 0, 0, 0	input
  5:	 LD 7, -1(5)	return to caller
* code for output routine
  6:	 ST 0, -1(5)	store return
  7:	 LD 0, 0(0)	load output value
  8:	 OUT 7, -1, 5	output
  9:	 LD 5, 0(6)	return to caller
  10:	 LDA 0, 0(0)	jump around i/o code
* End of standard prelude.
TEST
    TEST
      11:	 ST 5, 0(5)	push ofp
  12:	 LDA 5, 0(5)	push frame
  13:	 LDA 0, 1(7)	load ac with ret ptr
  14:	 LDA 7, 7(0)	jump to main loc
  15:	 LD 5, 0(5)	pop frame
* End of Execution
  16:	 HALT 0, 0, 0	
