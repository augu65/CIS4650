
/*
  Created by: Kaylee Bigelow and Jonah Stegman
  File Name: codeGenerator.java
*/

import java.util.HashMap;
import java.util.ArrayList;
import java.util.Set;

import absyn.*;

public class codeGenerator implements AbsynVisitor {
    int mainEntry, globalOffset;
    int emitLoc; // curr instruction
    int highEmitLoc; // next available space
    HashMap<String, ArrayList<NodeType>> table;
    ArrayList<String> callArgs;
    final int ofpFO = 0;
    final int retOF = -1;
    final int initOF = -2;
    final int pc = 7;
    final int gp = 6;
    final int fp = 5;
    final int ac = 0;
    final int ac1 = 1;
    int globalLevel = 0;
    boolean flag = true;

    public codeGenerator() {
        mainEntry = 0; // change from 0 if find main func
        globalOffset = 0;
        table = new HashMap<String, ArrayList<NodeType>>();
        callArgs = new ArrayList<String>();
    }

    public void emitRO(String op, int r, int s, int t, String c) {
        System.out.printf("%3d: %5s %d, %d, %d", emitLoc, op, r, s, t);
        System.out.printf("\t%s\n", c);
        ++emitLoc;
        if (highEmitLoc < emitLoc)
            highEmitLoc = emitLoc;
    }

    public void emitRM(String op, int r, int d, int s, String c) {
        System.out.printf("%3d: %5s %d, %d(%d)", emitLoc, op, r, d, s);
        System.out.printf("\t%s\n", c);
        ++emitLoc;
        if (highEmitLoc < emitLoc)
            highEmitLoc = emitLoc;
    }

    public void emitRM_Abs(String op, int r, int a, String c) {
        System.out.printf("%3d: %5s %d, %d(%d) ", emitLoc, op, r, (a - (emitLoc + 1)), pc);
        System.out.printf("\t%s\n", c);

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

    public void insert(NodeType node) {
        if (!table.containsKey(node.name)) {
            ArrayList<NodeType> list = new ArrayList<NodeType>();
            list.add(node);
            table.put(node.name, list);
        } else {
            ArrayList<NodeType> list = table.get(node.name);
            list.add(node);
            table.put(node.name, list);
        }
    }

    private NodeType lookup(String name) {
        if (!table.containsKey(name)) {
            return null;
        } else {
            ArrayList<NodeType> list = table.get(name);
            NodeType curr = list.get(list.size() - 1);
            return curr;
        }
    }

    private void deleteLevel(int level) {
        Set<String> keys = table.keySet();
        ArrayList<String> deleteKeys = new ArrayList<String>();
        for (String key : keys) {
            ArrayList<NodeType> list = table.get(key);
            NodeType last = list.get(list.size() - 1);
            if (last.level == level) {
                list.remove(last);
                if (list.isEmpty()) {
                    deleteKeys.add(key);
                }
            }
        }
        keys.removeAll(deleteKeys);
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
        int funLoc = emitSkip(0);
        NodeType node = new NodeType("input", "VOID", 0, funLoc);
        insert(node);
        emitRM("ST", 0, retOF, fp, "store return");
        emitRO("IN", 0, 0, 0, "input");
        emitRM("LD", 7, -1, 5, "return to caller");

        emitComment("code for output routine");
        int funLoc2 = emitSkip(0);
        NodeType node2 = new NodeType("output", "-2", 0, funLoc2);
        insert(node2);
        emitRM("ST", 0, retOF, fp, "store return");
        emitRM("LD", 0, initOF, fp, "load output value");
        emitRO("OUT", 0, 0, 0, "output");
        emitRM("LD", 7, -1, 5, "return to caller");
        int savedLoc2 = emitSkip(0);
        emitBackup(savedLoc);
        emitRM_Abs("LDA", pc, savedLoc2, "jump around i/o code");
        emitRestore();
        emitComment("End of standard prelude.");

        // call the visit method for DecList
        globalOffset = initOF;
        trees.accept(visitor, initOF, false);

        // check if main is given
        // if mianEntry 0 throw error

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
        globalOffset = level;
        while (expList != null) {
            expList.head.accept(this, globalOffset, isAddr);
            if (expList.head.def != null) {
                try {
                    int temp = Integer.parseInt(expList.head.info);
                    callArgs.add("" + (globalOffset + 1));
                } catch (NumberFormatException e) {
                    callArgs.add(expList.head.def);
                }
            }
            expList = expList.tail;
        }
    }

    public void visit(AssignExp exp, int level, boolean isAddr) {
        emitComment("processing local var: " + exp.name.info);
        flag = false;
        exp.type.accept(this, level, true);
        exp.name.accept(this, level, false);
        globalOffset--;
        flag = true;
        NodeType node = new NodeType(exp.name.info, exp.type.def, globalLevel, Integer.parseInt(exp.name.def));
        insert(node);
    }

    public void visit(IfExp exp, int level, boolean isAddr) {
        exp.test.accept(this, level, isAddr);
        // skip jump
        int savedLoc = emitSkip(1);

        exp.thenpart.accept(this, level, isAddr);
        // skip jump
        int savedLoc2 = emitSkip(1);

        // jump to else
        emitBackup(savedLoc);
        if (exp.test.info.equals("true")) {
            emitRM("LDA", pc, savedLoc2 - savedLoc, pc, "");
        } else {
            emitRM(exp.test.def, ac, savedLoc2 - savedLoc, pc, "");
        }
        emitRestore();

        if (exp.elsepart != null) {
            exp.elsepart.accept(this, level, isAddr);
        }

        // jump around else
        int savedLoc3 = emitSkip(0);
        emitBackup(savedLoc2);
        emitRM("LDA", pc, savedLoc3 - savedLoc2 - 1, pc, "");
        emitRestore();
    }

    public void visit(IntExp exp, int level, boolean isAddr) {
        emitRM("LDC", 0, Integer.parseInt(exp.value), 0, "");
        emitRM("ST", 0, level, fp, "");
        globalOffset--;
    }

    public void visit(OpExp exp, int level, boolean isAddr) {
        switch (exp.op) {
        case OpExp.PLUS:
            exp.info = "+";
            break;
        case OpExp.MINUS:
            exp.info = "-";
            break;
        case OpExp.TIMES:
            exp.info = "*";
            break;
        case OpExp.OVER:
            exp.info = "/";
            break;
        case OpExp.EQ:
            exp.info = "==";
            break;
        case OpExp.LT:
            exp.info = "<";
            break;
        case OpExp.GT:
            exp.info = ">";
            break;
        case OpExp.LE:
            exp.info = "<=";
            break;
        case OpExp.GE:
            exp.info = ">=";
            break;
        case OpExp.NEQ:
            exp.info = "!=";
            break;
        case OpExp.ERROR:
            break;
        default:
            break;
        }
    }

    public void visit(RepeatExp exp, int level, boolean isAddr) {
        int top = emitSkip(0);
        exp.test.accept(this, level, isAddr);
        // skip jump
        int savedLoc = emitSkip(1);

        if (exp.exps != null) {
            exp.exps.accept(this, level, isAddr);
        }

        int savedLoc3 = emitSkip(0);
        emitRM("LDA", pc, top - savedLoc3 - 1, pc, "jump to while");

        // jump around while body
        int savedLoc2 = emitSkip(0);
        emitBackup(savedLoc);
        emitRM(exp.test.def, ac, savedLoc2 - savedLoc - 1, pc, "test condition");
        emitRestore();

    }

    public void visit(VarExp exp, int level, boolean isAddr) {
        if (flag) {
            if (exp.exprs != null) {
                exp.exprs.accept(this, level, isAddr);
            }
            NodeType var = lookup(exp.name);
            if (var != null) {
                if (isAddr) {
                    emitRM("LDA", 0, var.offset, fp, "");
                    emitRM("ST", 0, level, fp, "");
                } else if (!isAddr) {
                    emitRM("LD", 0, var.offset, fp, "");
                    emitRM("ST", 0, level, fp, "");
                }
                globalOffset = level - 1;
            }
        }
        exp.def = "" + level;
    }

    public void visit(TypeExp exp, int level, boolean isAddr) {
    }

    public void visit(FunExp exp, int level, boolean isAddr) {
        flag = false;
        exp.type.accept(this, level, isAddr);
        exp.name.accept(this, level, isAddr);
        flag = true;

        if (exp.name.info.equals("main")) {
            int loc = emitSkip(0);
            mainEntry = loc + 1;
        }

        globalLevel++;
        int funlevel = globalLevel;

        exp.funaddr = emitLoc;
        emitComment("processing function: " + exp.name.info);
        emitComment("jump around function body here");
        int savedLoc = emitSkip(1);
        int funLoc = emitSkip(0);
        exp.funaddr = funLoc;
        emitRM("ST", 0, retOF, fp, "save return address");

        if (exp.params != null) {
            exp.params.accept(this, level, isAddr);
        }

        NodeType node = new NodeType(exp.name.name, exp.params.info, globalLevel - 1, funLoc);
        insert(node);

        if (exp.compound != null) {
            emitComment("-> compound statement");
            exp.compound.accept(this, globalOffset, false);
        }

        emitRM("LD", pc, -1, fp, "return back to the caller");
        int savedLoc2 = emitSkip(0);
        emitBackup(savedLoc);
        emitRM("LDA", pc, (savedLoc2 - 1 - savedLoc), pc, "jump forward to finale");
        emitRestore();
        deleteLevel(globalLevel);
        globalLevel--;

    }

    public void visit(ParListExp exp, int level, boolean isAddr) {
        exp.paramlist.accept(this, level, isAddr);
        exp.param.accept(this, level, isAddr);
        exp.info = exp.paramlist.info + ", " + exp.param.info;
    }

    public void visit(ParamExp exp, int level, boolean isAddr) {
        flag = false;
        exp.type.accept(this, level, isAddr);
        exp.name.accept(this, globalOffset, isAddr);
        flag = true;
        globalOffset--;
        exp.info = exp.name.def;
    }

    public void visit(CompExp exp, int level, boolean isAddr) {
        if (exp.first != null) {
            exp.first.accept(this, level - 1, true);
        }
        if (exp.second != null)
            exp.second.accept(this, level - 2, false);

        emitRM("LD", ac, level - 1, fp, "");
        emitRM("LD", ac1, level - 2, fp, "");
        emitRM("ST", ac1, ac, ac, "");
        emitRM("ST", ac1, level, fp, "");
        exp.info = "true";
    }

    public void visit(ReturnExp exp, int level, boolean isAddr) {
        if (exp.exps != null) {
            exp.exps.accept(this, level, isAddr);
        }
    }

    public void visit(MathExp exp, int level, boolean isAddr) {
        exp.lhs.accept(this, level - 1, false);
        exp.op.accept(this, level, isAddr);
        exp.rhs.accept(this, level - 2, false);
        emitRM("LD", ac, level - 1, fp, "");
        emitRM("LD", ac1, level - 2, fp, "");

        switch (exp.op.info) {
        case "+":
            emitRO("ADD", ac, ac, ac1, "");
            exp.info = "true";
            break;
        case "-":
            emitRO("SUB", ac, ac, ac1, "");
            exp.info = "true";
            break;
        case "*":
            emitRO("MUL", ac, ac, ac1, "");
            exp.info = "true";
            break;
        case "/":
            emitRO("DIV", ac, ac, ac1, "");
            exp.info = "true";
            break;
        case "==":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "");
            // JEQ -> if ac != 0 false
            exp.info = "false";
            exp.def = "JNE";
            break;
        case "<":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "");
            // JGT -> if ac > 0 false
            exp.info = "false";
            exp.def = "JGT";
            break;
        case ">":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "");
            // JLT -> if ac < 0 false
            exp.info = "false";
            exp.def = "JLT";
            break;
        case "<=":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "");
            // JGE -> if ac >= 0 false
            exp.info = "false";
            exp.def = "JGE";
            break;
        case ">=":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "");
            // JGE -> if ac <= 0 false
            exp.info = "false";
            exp.def = "JLE";
            break;
        case "!=":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "");
            // JEQ -> if ac == 0 false
            exp.info = "false";
            exp.def = "JEQ";
            break;
        default:
            break;
        }
        emitRM("ST", ac, level, fp, "");

    }

    public void visit(CallExp exp, int level, boolean isAddr) {
        callArgs.clear();
        flag = false;
        exp.name.accept(this, level, isAddr);
        flag = true;
        if (exp.args != null) {
            exp.args.accept(this, level, isAddr);
            for (int i = 0; i < callArgs.size(); i++) {
                emitRM("LD", ac, Integer.parseInt(callArgs.get(i)), fp, "load valaue to ac");
                emitRM("ST", ac, level + initOF - i, fp, "store arg value");
            }
        }
        NodeType n = lookup(exp.name.name);
        emitRM("ST", fp, level + ofpFO, fp, "store current fp");
        emitRM("LDA", fp, level, fp, "push new frame");
        emitRM("LDA", ac, 1, pc, "save return in ac");
        int savedLoc = emitSkip(0);

        emitRM("LDA", pc, (n.offset - savedLoc - 1), pc, "relative jump to function entry");

        // this happens when we get back
        emitRM("LD", fp, ofpFO, fp, "pop current frame");
        emitRM("ST", 0, level, fp, "store return");
        exp.def = "" + level;
        callArgs.clear();
    }

}