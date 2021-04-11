
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
    String funct;
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
    int inParam = 0;

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
        if (mainEntry == 0) {
            // THROW AN ERROR
            emitRO("HALT", 0, 0, 0, "");
        }

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

    public void visit(ExpList expList, int level, boolean isAddr) {
        globalOffset = level;
        while (expList != null) {
            expList.head.accept(this, globalOffset, isAddr);
            if (expList.head.def != null) {
                try {
                    int temp = Integer.parseInt(expList.head.info);
                    callArgs.add("" + (globalOffset + 1));
                } catch (NumberFormatException e) {
                    System.err.println(expList.head.info);
                    callArgs.add(expList.head.def);
                }
            }
            expList = expList.tail;
        }
    }

    public void visit(AssignExp exp, int level, boolean isAddr) {
        emitComment("processing var: " + exp.name.info);
        flag = false;
        exp.type.accept(this, level, true);
        exp.name.accept(this, level, false);
        if (exp.num != null) {
            exp.num.accept(this, level, isAddr);
        }
        globalOffset--;
        flag = true;
        NodeType node;
        if (exp.num != null) {
            try {
                if (Integer.parseInt(exp.num.info) < 1) {
                    // error
                    emitRO("HALT", 0, 0, 0, "");
                } else {
                    globalOffset = globalOffset - Integer.parseInt(exp.num.info) + 1;
                }
            } catch (NumberFormatException e) {

            }
            node = new NodeType(exp.name.info, exp.type.def + "[" + exp.num.info + "]", globalLevel,
                    Integer.parseInt(exp.name.def));
        } else {
            node = new NodeType(exp.name.info, exp.type.def, globalLevel, Integer.parseInt(exp.name.def));
        }
        insert(node);
        emitComment("<- varDec");
    }

    public void visit(IfExp exp, int level, boolean isAddr) {
        emitComment("-> if");
        exp.test.accept(this, level, isAddr);
        // skip jump
        int savedLoc = emitSkip(1);

        exp.thenpart.accept(this, level, isAddr);
        // skip jump
        int savedLoc2 = emitSkip(1);

        // jump to else
        emitBackup(savedLoc);
        if (exp.test.info.equals("true")) {
            emitRM("LDA", pc, savedLoc2 - savedLoc, pc, "if: jump to else");
        } else {
            emitRM(exp.test.def, ac, savedLoc2 - savedLoc, pc, "if: jump to else");
        }
        emitRestore();

        if (exp.elsepart != null) {
            exp.elsepart.accept(this, level, isAddr);
        }

        // jump around else
        int savedLoc3 = emitSkip(0);
        emitBackup(savedLoc2);
        emitRM("LDA", pc, savedLoc3 - savedLoc2 - 1, pc, "jump to end");
        emitRestore();
        emitComment("<- if");
    }

    public void visit(IntExp exp, int level, boolean isAddr) {
        emitComment("-> constant");
        emitRM("LDC", 0, Integer.parseInt(exp.value), 0, "load constant");
        emitComment("<- constant");
        emitRM("ST", 0, level, fp, "op: push left");
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
        emitComment("-> while");
        int top = emitSkip(0);
        exp.test.accept(this, level, isAddr);
        // skip jump
        int savedLoc = emitSkip(1);

        if (exp.exps != null) {
            exp.exps.accept(this, level, isAddr);
        }

        int savedLoc3 = emitSkip(0);
        emitRM("LDA", pc, top - savedLoc3 - 1, pc, "while: absolute jump to test");

        // jump around while body
        int savedLoc2 = emitSkip(0);
        emitBackup(savedLoc);
        emitRM(exp.test.def, ac, savedLoc2 - savedLoc - 1, pc, "while: jump to end");
        emitRestore();
        emitComment("<- while");
    }

    public void visit(VarExp exp, int level, boolean isAddr) {
        if (flag) {
            if (exp.exprs != null) {
                exp.exprs.accept(this, level, isAddr);
            }
            NodeType var = lookup(exp.name);
            if (var != null) {
                int pos = 0;

                emitComment("looking up id: " + exp.name);
                if (var.def.contains("[") && exp.exprs == null) {
                    // error
                    emitRO("HALT", 0, 0, 0, "out of bounds");
                } else if (!var.def.contains("[") && exp.exprs != null) {
                    // error
                    emitRO("HALT", 0, 0, 0, "out of bounds");
                } else if (var.def.contains("[") && exp.exprs != null) {
                    // check bounds

                    String temp = var.def.split("\\[")[1];
                    emitComment("-> array bounds check");
                    try {
                        if (Integer.parseInt(exp.exprs.info) < 0) {
                            // error
                            emitRO("HALT", 0, 0, 0, "out of bounds");
                        } else if (Integer.parseInt(exp.exprs.info) >= Integer.parseInt(temp.split("]")[0])) {
                            // error
                            emitRO("HALT", 0, 0, 0, "out of bounds");
                        }
                        pos = Integer.parseInt(exp.exprs.info);
                    } catch (NumberFormatException e) {
                        // not a int

                        pos = Integer.parseInt(exp.exprs.def); // idk what do here

                        System.err.println(exp.exprs.info);
                        System.err.println(exp.exprs.def);
                        int arrSize = Integer.parseInt(temp.split("]")[0]);
                        int accessSize = Integer.parseInt(exp.exprs.def);
                        emitRM("LDC", ac, arrSize, 0, "load constant");
                        emitRM("LD", ac1, accessSize, fp, "load id value");
                        emitRO("SUB", ac, ac1, ac, "op -");
                        emitRM("JGT", ac, 1, pc, "bouns check: jump");
                        emitRO("HALT", 0, 0, 0, "out of bounds");

                    }
                    emitComment("<- array bounds check");
                }
                if (isAddr) {
                    emitRM("LDA", 0, var.offset - pos, fp, "load id address");
                    emitComment("<- id");
                    emitRM("ST", 0, level, fp, "op: push left");
                } else if (!isAddr) {
                    emitRM("LD", 0, var.offset - pos, fp, "load id value");
                    emitComment("<- id");
                    emitRM("ST", 0, level, fp, "op: push left");
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
        funct = exp.name.info;
        exp.funaddr = emitLoc;
        emitComment("processing function: " + exp.name.info);
        emitComment("jump around function body here");
        int savedLoc = emitSkip(1);
        int funLoc = emitSkip(0);
        exp.funaddr = funLoc;
        emitRM("ST", 0, retOF, fp, "save return address");

        if (exp.params != null) {
            exp.params.accept(this, initOF, true);
        }

        NodeType node = new NodeType(exp.name.name, exp.params.info, globalLevel - 1, funLoc);
        insert(node);

        System.err.println("global " + globalOffset);
        if (exp.compound != null) {
            emitComment("-> compound statement");
            exp.compound.accept(this, globalOffset, false);
            emitComment("<- compound statement");
        }

        emitRM("LD", pc, -1, fp, "return back to the caller");
        int savedLoc2 = emitSkip(0);
        emitBackup(savedLoc);
        emitRM("LDA", pc, (savedLoc2 - 1 - savedLoc), pc, "jump around func body");
        emitRestore();
        deleteLevel(globalLevel);
        globalLevel--;
        emitComment("<- funExp");
    }

    public void visit(ParListExp exp, int level, boolean isAddr) {
        exp.paramlist.accept(this, globalOffset, isAddr);
        exp.param.accept(this, level, isAddr);
        exp.info = exp.paramlist.info + ", " + exp.param.info;

    }

    public void visit(ParamExp exp, int level, boolean isAddr) {
        if (!isAddr)
            flag = false;
        exp.type.accept(this, level, isAddr);
        exp.name.accept(this, level, isAddr);
        NodeType n = lookup(exp.name.name);
        if (n == null) {
            NodeType node = new NodeType(exp.name.info, exp.type.def, globalLevel, Integer.parseInt(exp.name.def));
            insert(node);
        }
        flag = true;
        exp.info = exp.name.def;
        globalOffset--;
    }

    public void visit(CompExp exp, int level, boolean isAddr) {
        if (exp.first != null) {
            exp.first.accept(this, level - 1, true);
        }
        if (exp.second != null)
            exp.second.accept(this, level - 2, false);

        emitRM("LD", ac, level - 1, fp, "load left");
        emitRM("LD", ac1, level - 2, fp, "load right");
        emitRM("ST", ac1, ac, ac, "store in ac1");
        emitRM("ST", ac1, level, fp, "assign: store value");
        exp.info = "true";
    }

    public void visit(ReturnExp exp, int level, boolean isAddr) {
        emitComment("-> return");
        if (exp.exps != null) {
            exp.exps.accept(this, level, isAddr);
        }
        emitRM("LD", pc, -1, fp, "return back to the caller");
        emitComment("<- return");
    }

    public void visit(MathExp exp, int level, boolean isAddr) {
        emitComment("-> mathExp");
        if (inParam == 1) {
            inParam++;
        }
        exp.lhs.accept(this, level - 1, false);
        exp.op.accept(this, level, isAddr);
        exp.rhs.accept(this, level - 2, false);
        emitRM("LD", ac, level - 1, fp, "load right");
        emitRM("LD", ac1, level - 2, fp, "load left");

        switch (exp.op.info) {
        case "+":
            emitRO("ADD", ac, ac, ac1, "op +");
            exp.info = "true";
            // exp.def = "" + level;
            break;
        case "-":
            emitRO("SUB", ac, ac, ac1, "op -");
            exp.info = "true";
            // exp.def = "" + level;
            break;
        case "*":
            emitRO("MUL", ac, ac, ac1, "op *");
            exp.info = "true";
            // exp.def = "" + level;
            break;
        case "/":
            emitRO("DIV", ac, ac, ac1, "op /");
            exp.info = "true";
            // exp.def = "" + level;
            break;
        case "==":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "op ==");
            // JEQ -> if ac != 0 false
            exp.info = "false";
            exp.def = "JNE";
            break;
        case "<":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "op <");
            // JGT -> if ac > 0 false
            exp.info = "false";
            exp.def = "JGT";
            break;
        case ">":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "op >");
            // JLT -> if ac < 0 false
            exp.info = "false";
            exp.def = "JLT";
            break;
        case "<=":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "op <=");
            // JGE -> if ac >= 0 false
            exp.info = "false";
            exp.def = "JGE";
            break;
        case ">=":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "op >=");
            // JGE -> if ac <= 0 false
            exp.info = "false";
            exp.def = "JLE";
            break;
        case "!=":
            // subtract and put in ac
            emitRO("SUB", ac, ac, ac1, "op !=");
            // JEQ -> if ac == 0 false
            exp.info = "false";
            exp.def = "JEQ";
            break;
        default:
            break;
        }
        emitRM("ST", ac, level, fp, "store value from math");
        inParam--;
        if (inParam == 1) {
            callArgs.add("" + level);
        }
        emitComment("<- mathExp");
    }

    public void visit(CallExp exp, int level, boolean isAddr) {
        callArgs.clear();

        flag = false;
        exp.name.accept(this, level, isAddr);
        flag = true;
        emitComment("-> call of function: " + exp.name.name);
        System.err.println("------------------" + exp.name.name + "---------------");

        if (exp.args != null) {
            inParam = 1;
            exp.args.accept(this, level, false);
            inParam = 0;
            int j = 0;
            System.err.println("size " + callArgs.size());
            for (int i = callArgs.size() - 1; i >= 0; i--) {
                emitRM("LD", ac, Integer.parseInt(callArgs.get(i)), fp, "load value to ac");
                emitRM("ST", ac, level + initOF - j, fp, "store arg value");
                j++;
            }
        }
        System.err.println("==================================");

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
        emitComment("<- call");
        callArgs.clear();
    }

}