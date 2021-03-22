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
        NodeType test = lookup(exp.name.info);
        if (test != null && test.level == globalLevel) {
            System.err.println("Error: redefined variable " + exp.name.info + " at the same level");
        } else {
            if (exp.type.def.equals("VOID")) {
                System.err.println("Error: variables cannot be defined as VOID type");
                exp.type.def = "INT";
            }
            NodeType node;
            if (exp.num != null) {
                node = new NodeType(exp.name.info, exp.type.def + "[" + exp.num.info + "]", globalLevel);
            } else {
                node = new NodeType(exp.name.info, exp.type.def, globalLevel);
            }
            insert(node);
        }
    }

    public void visit(IfExp exp, int level) {
        if (exp.test != null) {
            exp.test.accept(this, level);
            String temp[] = exp.test.def.split(" ");
            for (int i = 0; i < temp.length; i++) {
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
        if (exp.exprs != null) {
            exp.exprs.accept(this, level);
        }

        NodeType test = lookup(exp.name);
        if (test != null) {
            if (exp.exprs != null) {
                exp.def = test.def + "[" + exp.exprs.info + "]";
            } else {
                exp.def = test.def;
            }
        } else {
            exp.def = "ERROR - undefined";
        }
    }

    public void visit(TypeExp exp, int level) {
    }

    public void visit(FunExp exp, int level) {
        exp.type.accept(this, level);
        exp.name.accept(this, level);

        NodeType test = lookup(exp.name.info);
        globalLevel++;
        level++;
        indent(level);
        System.out.println("Entering the scope for function " + exp.name.info + ":");
        if (exp.params != null) {
            exp.params.accept(this, level);
        }

        if (test != null && test.level == globalLevel) {
            System.err.println("Error: Function name already exists at the same level");
        } else {
            exp.type.def = "(" + exp.params.def.replaceAll("VOID", "INT") + ") -> " + exp.type.def;
            NodeType node = new NodeType(exp.name.info, exp.type.def, globalLevel - 1);
            insert(node);
        }
        funcType = exp.type.def;
        if (exp.compound != null) {
            exp.compound.accept(this, level);
        }
        if (funcType != null) {
            if (funcType.split(" ")[2].equals("INT")) {
                System.err.println("Error: Function declared with type INT but has no return");
            }
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
        NodeType test = lookup(exp.name.info);
        if (test != null && test.level == globalLevel) {
            System.err.println("Error: Variable " + exp.name.info + " already exist at the same level");
        } else {
            if (exp.type.def.equals("VOID")) {
                System.err.println("Error: variables cannot be defined as VOID type");
                exp.type.def = "INT";
            }
            NodeType node = new NodeType(exp.name.info, exp.type.def, globalLevel);
            insert(node);
        }

    }

    public void visit(CompExp exp, int level) {
        if (exp.first != null)
            exp.first.accept(this, level);
        if (exp.second != null)
            exp.second.accept(this, level);
        if (exp.first != null && exp.second != null) {
            if (!exp.first.def.contains("ERROR") && !exp.second.def.contains("ERROR")) {
                String first = exp.first.def;
                String second = exp.second.def;
                int array = 0;
                int array2 = 0;
                int arraySize = 0;
                int array2Size = 0;
                if (exp.first.def.contains("[")) {
                    array = 1;
                    String[] allFirst = exp.first.def.split("\\[");
                    arraySize = Integer.parseInt(allFirst[1].split("]")[0]);
                    first = allFirst[0];
                    if (allFirst.length > 2) {
                        array = 0;
                    }
                }
                if (exp.second.def.contains("[")) {
                    array2 = 1;
                    String[] allSecond = exp.second.def.split("\\[");
                    array2Size = Integer.parseInt(allSecond[1].split("]")[0]);
                    second = allSecond[0];
                    if (allSecond.length > 2) {
                        array2 = 0;
                    }
                }
                if (array != array2) {
                    System.err.println("Error: Invalid types for statement");
                    exp.def = "ERROR";
                    return;
                } else if (array == 1) {
                    if (arraySize != array2Size) {
                        System.err.println("Error: Mismatch array sizes");
                        exp.def = "ERROR";
                        return;
                    }
                }

                if (first.equals(second)) {
                    exp.def = first;
                } else if (!first.equals(second)) {
                    exp.def = "ERROR";
                    System.err.println("Error: Invalid types for statement");
                }
            } else if (exp.first.def.equals("ERROR - undefined")) {
                System.err.println("Error: Variable not defined");
            }
        } else {
            exp.def = "ERROR";
        }
    }

    public void visit(ReturnExp exp, int level) {
        if (exp.exps != null) {
            exp.exps.accept(this, level);
            if (!exp.exps.def.equals(funcType.split(" ")[2])) {
                System.err.println("Error: Function return type mismatch");
            }
        } else {
            if (!funcType.split(" ")[2].equals("VOID")) {
                System.err.println("Error: Function return type mismatch");
            }
        }
        funcType = null;
    }

    public void visit(MathExp exp, int level) {
        exp.lhs.accept(this, level);
        exp.op.accept(this, level);
        exp.rhs.accept(this, level);

        if (!exp.lhs.def.contains("ERROR") && !exp.rhs.def.contains("ERROR")) {
            String left = exp.lhs.def;
            String right = exp.rhs.def;
            int array = 0;
            int array2 = 0;
            int arraySize = 0;
            int array2Size = 0;
            if (exp.lhs.def.contains("[")) {
                array = 1;
                String[] allFirst = exp.lhs.def.split("\\[");
                arraySize = Integer.parseInt(allFirst[1].split("]")[0]);
                left = allFirst[0];
                if (allFirst.length > 2) {
                    array = 0;
                }
            }
            if (exp.rhs.def.contains("[")) {
                array2 = 1;
                String[] allSecond = exp.rhs.def.split("\\[");
                array2Size = Integer.parseInt(allSecond[1].split("]")[0]);
                right = allSecond[0];
                if (allSecond.length > 2) {
                    array2 = 0;
                }
            }

            if (array != array2) {
                System.err.println("Error: Invalid types for statement");
                exp.def = "ERROR";
                return;
            } else if (array == 1) {
                if (arraySize != array2Size) {
                    System.err.println("Error: Mismatch array sizes");
                    exp.def = "ERROR";
                    return;
                }
            }

            if (left.equals(right)) {
                exp.def = left;
            } else if (!left.equals(right)) {
                exp.def = "ERROR";
                System.err.println("Error: Invalid types for equation");
            }
        } else if (exp.lhs.def.equals("ERROR - undefined") || exp.rhs.def.equals("ERROR - undefined")) {
            System.err.println("Error: Variable not defined");
            exp.def = "ERROR";
        } else {
            exp.def = "ERROR";
        }
    }

    public void visit(CallExp exp, int level) {
        exp.name.accept(this, level);
        if (exp.args != null)
            exp.args.accept(this, level);
        NodeType value = lookup(exp.name.info);
        if (value != null) {
            exp.def = value.def.split(" ")[2];
        } else {
            exp.def = "ERROR";
            System.err.println("Error: Unknown function");
        }
    }

}
