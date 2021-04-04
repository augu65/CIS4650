
/*
  Created by: Kaylee Bigelow and Jonah Stegman
  File Name: codeGenerator.java
*/

import absyn.*;

public class codeGenerator implements AbsynVisitor {
    int mainEntry, globalOffset;
    int emitLoc; // curr instruction
    int highEmitLoc; // next available space
    int ofpFO;
    final int pc = 7;
    final int gp = 6;
    final int fp = 5;
    final int ac = 0;
    final int ac1 = 1;

    public void emitRO(String op, int r, int s, int t, String c) {
        System.out.print("  " + emitLoc + ":\t " + op + " " + r + ", " + s + ", " + t);
        System.out.print("\t" + c + "\n");
        ++emitLoc;
        if (highEmitLoc < emitLoc)
            highEmitLoc = emitLoc;
    }

    public void emitRM(String op, int r, int d, int s, String c) {
        System.out.print("  " + emitLoc + ":\t " + op + " " + r + ", " + d + "(" + s + ")");
        System.out.print("\t" + c + "\n");
        ++emitLoc;
        if (highEmitLoc < emitLoc)
            highEmitLoc = emitLoc;
    }

    public void emitRM_Abs(String op, int r, int a, String c) {
        System.out.print("  " + emitLoc + ":\t " + op + " " + r + ", " + (a - (emitLoc + 1)) + "(" + pc + ")");
        System.out.print("\t" + c + "\n");
        ++emitLoc;
        if (highEmitLoc < emitLoc)
            highEmitLoc = emitLoc;
    }

    public int emitSkip(int distance) {
        int i = emitLoc;
        emitLoc += distance;
        if (highEmitLoc < emitLoc) {
            highEmitLoc = emitLoc;
        }
        return i;
    }

    public void emitComment(String c) {
        System.out.println("* " + c);
    }

    public void emitBackup(int loc) {
        if (loc > highEmitLoc) {
            emitComment("BUG in emitBackup");
        }
        emitLoc = loc;
    }

    public void emitRestore() {
        emitLoc = highEmitLoc;
    }

    public void visit(Absyn trees, codeGenerator visitor) {
        // generate the prelude
        emitComment("Standard prelude:");
        emitRM("LD", gp, 0, ac, "load gp with maxaddress");
        emitRM("LDA", fp, 0, gp, "copy to gp to fp");
        emitRM("ST", ac, 0, ac, "clear location 0");

        // generate the i/o routines
        emitComment("Jump around i/o routines here");
        emitComment("code for input routine");
        int savedLoc = emitSkip(1);
        emitRM("ST", 0, -1, fp, "store return");
        emitRO("IN", 0, 0, 0, "input");
        emitRM("LD", 7, -1, 5, "return to caller");

        emitComment("code for output routine");
        emitRM("ST", 0, -1, fp, "store return");
        emitRM("LD", 0, 0, 0, "load output value");
        emitRO("OUT", pc, -1, fp, "output");
        emitRM("LD", fp, 0, gp, "return to caller");
        int savedLoc2 = emitSkip(0);
        emitBackup(savedLoc);
        emitRM_Abs("LDA", pc, savedLoc2, "jump around i/o code");
        emitRestore();
        emitComment("End of standard prelude.");

        // call the visit method for DecList
        trees.accept(visitor, 0, false);

        // generate finale
        emitRM("ST", fp, globalOffset + ofpFO, fp, "push ofp");
        emitRM("LDA", fp, globalOffset, fp, "push frame");
        emitRM("LDA", ac, 1, pc, "load ac with ret ptr");
        emitRM_Abs("LDA", pc, mainEntry, "jump to main loc");
        emitRM("LD", fp, ofpFO, fp, "pop frame");

        emitComment("End of Execution");
        emitRO("HALT", 0, 0, 0, "");
    }

    final static int SPACES = 4;

    private void indent(int level) {
        for (int i = 0; i < level * SPACES; i++)
            System.out.print(" ");
    }

    public void visit(ExpList expList, int level, boolean isAddr) {
        while (expList != null) {
            expList.head.accept(this, level, isAddr);
            expList = expList.tail;
        }
    }

    public void visit(AssignExp exp, int level, boolean isAddr) {
        exp.type.accept(this, level, isAddr);
        exp.name.accept(this, level, isAddr);
    }

    public void visit(IfExp exp, int level, boolean isAddr) {
        if (exp.test != null) {
            exp.test.accept(this, level, isAddr);
        }
        level++;
        indent(level);
        if (exp.thenpart != null)
            exp.thenpart.accept(this, level, isAddr);
        indent(level);
        if (exp.elsepart != null) {
            indent(level);
            exp.elsepart.accept(this, level, isAddr);
            indent(level);
        }
        level--;
    }

    public void visit(IntExp exp, int level, boolean isAddr) {
    }

    public void visit(OpExp exp, int level, boolean isAddr) {
    }

    public void visit(RepeatExp exp, int level, boolean isAddr) {
        if (exp.test != null) {
            exp.test.accept(this, level, isAddr);
        }
        level++;
        if (exp.exps != null) {
            indent(level);
            if (exp.exps != null)
                exp.exps.accept(this, level, isAddr);
            indent(level);
        }
        level--;
    }

    public void visit(VarExp exp, int level, boolean isAddr) {
        if (exp.exprs != null) {
            exp.exprs.accept(this, level, isAddr);
        }
    }

    public void visit(TypeExp exp, int level, boolean isAddr) {
    }

    public void visit(FunExp exp, int level, boolean isAddr) {
        exp.type.accept(this, level, isAddr);
        exp.name.accept(this, level, isAddr);

        exp.funaddr = emitLoc;

        level++;
        indent(level);
        if (exp.params != null) {
            exp.params.accept(this, level, isAddr);
        }
        if (exp.compound != null) {
            exp.compound.accept(this, level, isAddr);
        }

        int savedLoc = emitSkip(1);
        emitRM("ST", 0, -1, fp, "save return address");
        emitRM("LD", pc, -1, fp, "return back to the caller");
        emitBackup(savedLoc);
        emitRM("LDA", pc, 2, pc, "jump forward to finale");
        emitRestore();

        indent(level);
        level--;
    }

    public void visit(ParListExp exp, int level, boolean isAddr) {
        exp.paramlist.accept(this, level, isAddr);
        exp.param.accept(this, level, isAddr);
    }

    public void visit(ParamExp exp, int level, boolean isAddr) {
        exp.type.accept(this, level, isAddr);
        exp.name.accept(this, level, isAddr);
    }

    public void visit(CompExp exp, int level, boolean isAddr) {
        if (exp.first != null)
            exp.first.accept(this, level, isAddr);
        if (exp.second != null)
            exp.second.accept(this, level, isAddr);
    }

    public void visit(ReturnExp exp, int level, boolean isAddr) {
        if (exp.exps != null) {
            exp.exps.accept(this, level, isAddr);
        }
    }

    public void visit(MathExp exp, int level, boolean isAddr) {
        exp.lhs.accept(this, level, isAddr);
        exp.op.accept(this, level, isAddr);
        exp.rhs.accept(this, level, isAddr);
    }

    public void visit(CallExp exp, int level, boolean isAddr) {
        exp.name.accept(this, level, isAddr);
        if (exp.args != null) {
            exp.args.accept(this, level, isAddr);
        }
    }

}