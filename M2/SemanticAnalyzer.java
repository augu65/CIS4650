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
    String type = null;
    String funcType = null;
    String name = null;
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

    private String lookup(String name, String def) {
        if (!table.containsKey(name)) {
            return "Error: Variable not defined";
        } else {
            ArrayList<NodeType> list = table.get(name);
            NodeType curr = list.get(list.size() - 1);
            if(def == null){
                return curr.def;
            }
            if (curr.def.equals(def)) {
                return "match";
            } else {
                return "Error: Type don't match definition";
            }
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

    public void printLevel(int level){
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
        name = null;
        type = null;
        exp.type.accept(this, level);
        exp.name.accept(this, level);
        if (exp.num != null){
            exp.num.accept(this, level);
            if (!type.contains("INT")) {
                System.err.println("Error: Invalid array type");
            }
        }
        NodeType node = new NodeType(name, type, globalLevel);
        insert(node);
    }

    public void visit(IfExp exp, int level) {
        if(exp.test != null)
            exp.test.accept(this, level);
        globalLevel++;
        level++;
        indent(level);
        System.out.println("Entering a new block");
        if (exp.thenpart !=null)
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
        if(exp.value != null){
            type = type+" ["+exp.value+"]";
        }else{
            type = type + "[Unknown]";
        }
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
        }
        level++;
        if (exp.exps != null){
            indent(level);
            System.out.println("Entering a new block");
            if(exp.exps != null)
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
        name = exp.name;
        if (exp.exprs != null)
            exp.exprs.accept(this, level);
    }

    public void visit(TypeExp exp, int level) {
        switch (exp.type) {
        case TypeExp.INT:
            type = "INT";
            break;
        case TypeExp.VOID:
            type = "VOID";
            break;
        default:
           type = "Unknown";
        }
    }

    public void visit(FunExp exp, int level) {
        exp.type.accept(this, level);
        exp.name.accept(this, level);
        funcType = type;
        type = "(" + type + ") -> " + type;
        NodeType node = new NodeType(name, type, globalLevel);
        insert(node);
        globalLevel++;
        level++;
        indent(level);
        System.out.println("Entering the scope for function " + name + ":");
        if (exp.params != null) {
            exp.params.accept(this, level);
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
        printLevel(level);
        name = null;
        type = null;
        funcType = null;
    }

    public void visit(ParListExp exp, int level) {
        exp.paramlist.accept(this, level);
        exp.param.accept(this, level);
    }

    public void visit(ParamExp exp, int level) {
        exp.type.accept(this, level);
        exp.name.accept(this, level);
    }

    public void visit(CompExp exp, int level) {
        if (exp.first != null)
            exp.first.accept(this, level);
        if (exp.second != null)
            exp.second.accept(this, level);
    }

    public void visit(ReturnExp exp, int level) {
        exp.exps.accept(this, level);
        String result = lookup(name,null);
        if(result.contains("Error:")){
            System.err.println(result);
        } else if(!funcType.equals(result)){
            System.err.println("Error: invalid return type");
        }


    }

    public void visit(MathExp exp, int level) {
        exp.lhs.accept(this, level);
        String result = lookup(name, null);
        if(result.contains("Error:")){
            System.err.println(result);
        }
        exp.op.accept(this, level);
        exp.rhs.accept(this, level);
        String result2 = lookup(name, null);
        if (result2.contains("Error:")) {
            System.err.println(result2);
        }
        if(!result.contains("Error:")&&!result2.contains("Error:")){
            if (result != result2) {
                System.err.println("Error: invalid ");
            }
        }
    }

    public void visit(CallExp exp, int level) {
        exp.name.accept(this, level);
        if (exp.args != null)
            exp.args.accept(this, level);
    }

}
