/*
  Created by: Kaylee Bigelow and Jonah Stegman
  File Name: codeGenerator.java
*/

import absyn.*;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Set;

public class codeGenerator implements AbsynVisitor {
    int mainEntry, globalOffset;

    public codeGenerator() {

    }

    // public void emitRO(char *op, int r, int s, int t, char *c){
    // fprintf(code, "%3d: %5s %d, %d, %d", emitLoc, op, r, s, t);
    // fprintf(code, "\t%s\n",c);
    // ++emitLoc;
    // if( highEmitLoc < emitLoc)
    // highEmitLoc = emitLoc;
    // }

    // public void emitRM(char *op, int r, int d, int s, char *c){
    // fprintf(code, "%3d: %5s %d, %d, %d", emitLoc, op, r, d, s);
    // fprintf(code, "\t%s\n",c);
    // ++emitLoc;
    // if( highEmitLoc < emitLoc)
    // highEmitLoc = emitLoc;
    // }

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
        switch (exp.op) {
        case OpExp.PLUS:
            break;
        case OpExp.MINUS:
            break;
        case OpExp.TIMES:
            break;
        case OpExp.OVER:
            break;
        case OpExp.EQ:
            break;
        case OpExp.LT:
            break;
        case OpExp.GT:
            break;
        case OpExp.LE:
            break;
        case OpExp.GE:
            break;
        case OpExp.NEQ:
            break;
        case OpExp.ERROR:
            break;
        default:
            break;
        }
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

        level++;
        indent(level);
        if (exp.params != null) {
            exp.params.accept(this, level, isAddr);
        }
        if (exp.compound != null) {
            exp.compound.accept(this, level, isAddr);
        }
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