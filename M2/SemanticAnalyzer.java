/*
  Created by: Kaylee Bigelow and Jonah Stegman
  File Name: SemanticAnalyzer.java
*/

import absyn.*;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Set;

public class SemanticAnalyzer implements AbsynVisitor {

    HashMap<String, ArrayList<NodeType>> table;
    int globalLevel = 0;
    String funcType = null;
    boolean flag = false;
    public SemanticAnalyzer() {
        table = new HashMap<String, ArrayList<NodeType>>();
    }

    private void insert(NodeType node) {
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

    public void printLevel(int level) {
        level++;
        Set<String> keys = table.keySet();
        for (String key : keys) {
            ArrayList<NodeType> list = table.get(key);
            NodeType last = list.get(list.size() - 1);
            if (last.level == globalLevel) {
                indent(level);
                System.out.println(last.name + ": " + last.def);
            }
        }
        level--;
    }

    final static int SPACES = 4;

    private void indent(int level) {
        for (int i = 0; i < level * SPACES; i++)
            System.out.print(" ");
    }

    public void visit(ExpList expList, int level) {
        while (expList != null) {
            expList.head.accept(this, level);
            expList = expList.tail;
        }
    }

    public void visit(AssignExp exp, int level) {
        exp.type.accept(this, level);
        exp.name.accept(this, level);
        if (exp.num != null) {
            if (exp.type.def.equals("VOID")) {
                System.err.println("Error: array type can't be void");
            }
            exp.num.accept(this, level);
        }
        NodeType test = lookup(exp.name.def);
        if (test != null && test.level == globalLevel) {
            System.err.println("Error: redefined variable " + exp.name.def + " at the same level");
        } else {
            if (exp.type.def.equals("VOID")) {
                System.err.println("Error: variables cannot be defined as VOID type");
                exp.type.def = "INT";
            }
            NodeType node;
            if (exp.num != null) {
                node = new NodeType(exp.name.def, exp.type.def + " " + exp.num.def, globalLevel);
            } else {
                node = new NodeType(exp.name.def, exp.type.def, globalLevel);
            }
            insert(node);
        }
    }

    public void visit(IfExp exp, int level) {
        if (exp.test != null) {
            exp.test.accept(this, level);
            String temp[] = exp.test.def.split(" ");
            for(int i = 0; i<temp.length; i++){
                NodeType n = lookup(temp[i]);
                if (n != null && n.def.contains("VOID")) {
                    System.err.println("Error: if test can't be void");
                    break;
                }   
            }
        }
        globalLevel++;
        level++;
        indent(level);
        System.out.println("Entering a new block");
        if (exp.thenpart != null)
            exp.thenpart.accept(this, level);
        printLevel(level);
        deleteLevel(globalLevel);
        indent(level);
        System.out.println("Leaving a new block");
        if (exp.elsepart != null) {
            indent(level);
            System.out.println("Entering a new block");
            exp.elsepart.accept(this, level);
            printLevel(level);
            indent(level);
            System.out.println("Leaving a new block");
            deleteLevel(globalLevel);
        }
        level--;
        globalLevel--;

    }

    public void visit(IntExp exp, int level) {
    }

    public void visit(OpExp exp, int level) {
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

    public void visit(RepeatExp exp, int level) {
        globalLevel++;
        if (exp.test != null) {
            exp.test.accept(this, level);
            String temp[] = exp.test.def.split(" ");
            for (int i = 0; i < temp.length; i++) {
                NodeType n = lookup(temp[i]);
                if (n != null && n.def.contains("VOID")) {
                    System.err.println("Error: While test can't be void");
                    break;
                }
            }
        }
        level++;
        if (exp.exps != null) {
            indent(level);
            System.out.println("Entering a new block");
            if (exp.exps != null)
                exp.exps.accept(this, level);
            printLevel(level);
            indent(level);
            System.out.println("Leaving a new block");
            deleteLevel(globalLevel);
        }
        level--;
        globalLevel--;
    }

    public void visit(VarExp exp, int level) {
        if (exp.exprs != null)
            exp.exprs.accept(this, level);
    }

    public void visit(TypeExp exp, int level) {
    }

    public void visit(FunExp exp, int level) {
        exp.type.accept(this, level);
        exp.name.accept(this, level);

        NodeType test = lookup(exp.name.def);
        globalLevel++;
        level++;
        indent(level);
        System.out.println("Entering the scope for function " + exp.name.def + ":");
        if (exp.params != null) {
            exp.params.accept(this, level);
        }

        if (test != null && test.level == globalLevel) {
            System.err.println("Error: Function name already exist at the same level");
        } else {
            exp.type.def = "(" + exp.params.def.replaceAll("VOID", "INT") + ") -> " + exp.type.def;
            NodeType node = new NodeType(exp.name.def, exp.type.def, globalLevel - 1);
            insert(node);
        }
        if (exp.compound != null) {
            exp.compound.accept(this, level);
        }
        printLevel(level);
        indent(level);
        System.out.println("Leaving the function scope");
        deleteLevel(globalLevel);
        globalLevel--;
        level--;
        funcType = null;
    }

    public void visit(ParListExp exp, int level) {
        exp.paramlist.accept(this, level);
        exp.param.accept(this, level);
    }

    public void visit(ParamExp exp, int level) {
        exp.type.accept(this, level);
        exp.name.accept(this, level);
        NodeType test = lookup(exp.name.def);
        if (test != null && test.level == globalLevel) {
            System.err.println("Error: Variable " + exp.name.def + " already exist at the same level");
        } else {
            if (exp.type.def.equals("VOID")) {
                System.err.println("Error: variables cannot be defined as VOID type");
                exp.type.def = "INT";
            }
            NodeType node = new NodeType(exp.name.def, exp.type.def, globalLevel);
            insert(node);
        }

    }

    public void visit(CompExp exp, int level) {
        if (exp.first != null)
            exp.first.accept(this, level);
        if (exp.second != null)
            exp.second.accept(this, level);
        String temp[] = exp.first.def.split(" ");
        String type = "";
        for (int i = 0; i < temp.length; i++) {
            NodeType n = lookup(temp[i]);
            if (n != null) {
                if (type.equals("")) {
                    type = n.def;
                } else if (!n.def.equals(type)) {
                    System.err.println("Error: Invalid comparison of types");
                    flag = true;
                    break;
                }
            } else {
                if (!temp[i].contains("[")) {
                    System.err.println("Error: variable not defined");
                } else if (!type.equals("INT") && !type.equals("")) {
                    System.err.println("Error: Invalid comparison of types");
                }
            }
        }
        if(!flag){
            String temp2[] = exp.second.def.split(" ");
            for (int i = 0; i < temp2.length; i++) {
                NodeType n = lookup(temp2[i]);
                if (n != null) {
                    if (type.equals("")) {
                        type = n.def;
                    } else if (!n.def.equals(type)) {
                        System.err.println("Error: Invalid comparison of types");
                        flag = true;
                        break;
                    }
                } else {
                    if (!temp2[i].contains("[")) {
                        System.err.println("Error: variable not defined");
                    } else if (!type.equals("INT") && !type.equals("")) {
                        System.err.println("Error: Invalid comparison of types");
                    }
                }
            }
        }
        flag = false;
    }

    public void visit(ReturnExp exp, int level) {
        if (exp.exps != null)
            exp.exps.accept(this, level);

    }

    public void visit(MathExp exp, int level) {
        exp.lhs.accept(this, level);
        exp.op.accept(this, level);
        exp.rhs.accept(this, level);
        String type = "";
        if (!flag) {
            String temp[] = exp.rhs.def.split(" ");
            for (int i = 0; i < temp.length; i++) {
                NodeType n = lookup(temp[i]);
                if(n != null){
                    if (type.equals("")) {
                        type = n.def;
                    } else if (!n.def.equals(type)) {
                        System.err.println("Error: Invalid math on different types");
                        flag = true;
                        break;
                    }
                } else {
                    if (!temp[i].contains("[")) {
                        System.err.println("Error: variable not defined");
                    } else if (!type.equals("INT")&& !type.equals("")) {
                        System.err.println("Error: Invalid math on different types");
                    }
                }
            }
        }
        if (!flag) {
            String temp[] = exp.lhs.def.split(" ");
            for (int i = 0; i < temp.length; i++) {
                NodeType n = lookup(temp[i]);
                if (n != null) {
                    if (type.equals("")) {
                        type = n.def;
                    } else if (!n.def.equals(type)) {
                        System.err.println("Error: Invalid math on different types");
                        flag = true;
                        break;
                    }
                }else{
                    if(!temp[i].contains("[")){
                        System.err.println("Error: variable not defined");
                    }else if(!type.equals("INT") && !type.equals("")){
                        System.err.println("Error: Invalid math on different types");
                    }
                }
            }
        }
        flag = false;
    }

    public void visit(CallExp exp, int level) {
        exp.name.accept(this, level);
        if (exp.args != null)
            exp.args.accept(this, level);
    }

}
