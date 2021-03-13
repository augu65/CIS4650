import absyn.*;
import jdk.nashorn.internal.runtime.regexp.joni.constants.NodeType;

import java.util.HashMap;
import java.util.ArrayList;

public class SemanticAnalyzer implements AbsynVisitor {

    HashMap<String, ArrayList<NodeType>> table;

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

    private boolean lookup(String name, String def) {
        if (!table.containsKey(name)) {
            return false;
        } else {
            ArrayList<NodeType> list = table.get(name);
            NodeType curr = list.get(list.size() - 1);
            if (curr.def.equals(def)) {
                return true;
            } else {
                return false;
            }
        }
    }

    private void deleteLevel(int level) {
        Set<String> keys = table.keySet();
        for (String key : keys) {
            ArrayList<NodeType> list = table.get(key);
            NodeType last = list.get(list.size() - 1);
            if (last.level == level) {
                list.remove(list.size() - 1);
                if (list.isEmpty()) {
                    table.remove(key);
                }
            }
        }
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
        indent(level);
        System.out.println("AssignExp:");
        level++;
        exp.type.accept(this, level);
        exp.name.accept(this, level);
        if (exp.num != null)
            exp.num.accept(this, level);
    }

    public void visit(IfExp exp, int level) {
        indent(level);
        System.out.println("IfExp:");
        level++;
        if (exp.test != null) {
            exp.test.accept(this, level);
        } else {
            indent(level);
            System.out.println("Error test case not found");
        }
        exp.thenpart.accept(this, level);
        if (exp.elsepart != null) {
            level--;
            indent(level);
            System.out.println("ElseExp:");
            level++;
            exp.elsepart.accept(this, level);
        }

    }

    public void visit(IntExp exp, int level) {
        indent(level);
        if (exp.value == null)
            System.out.println("IntExp: Error value not found");
        else
            System.out.println("IntExp: " + exp.value);
    }

    public void visit(OpExp exp, int level) {
        indent(level);
        System.out.print("OpExp:");
        switch (exp.op) {
        case OpExp.PLUS:
            System.out.println(" + ");
            break;
        case OpExp.MINUS:
            System.out.println(" - ");
            break;
        case OpExp.TIMES:
            System.out.println(" * ");
            break;
        case OpExp.OVER:
            System.out.println(" / ");
            break;
        case OpExp.EQ:
            System.out.println(" == ");
            break;
        case OpExp.LT:
            System.out.println(" < ");
            break;
        case OpExp.GT:
            System.out.println(" > ");
            break;
        case OpExp.LE:
            System.out.println(" <= ");
            break;
        case OpExp.GE:
            System.out.println(" >= ");
            break;
        case OpExp.NEQ:
            System.out.println(" != ");
            break;
        case OpExp.ERROR:
            System.out.println(" Unrecognized symbol found ");
            break;
        default:
            System.out.println("Unrecognized operator at line " + exp.row + " and column " + exp.col);
        }
        level++;
    }

    public void visit(RepeatExp exp, int level) {
        indent(level);
        System.out.println("RepeatExp:");
        level++;
        if (exp.test != null) {
            exp.test.accept(this, level);
        } else {
            indent(level);
            System.out.println("Error test case not found");
        }
        if (exp.exps != null)
            exp.exps.accept(this, level);
    }

    public void visit(VarExp exp, int level) {
        indent(level);
        if (exp.name == null) {
            System.out.println("VarExp: Error name not found");
        } else {
            System.out.println("VarExp: " + exp.name);
        }
        if (exp.exprs != null)
            exp.exprs.accept(this, level);
    }

    public void visit(TypeExp exp, int level) {
        indent(level);
        System.out.print("TypeExp: ");
        switch (exp.type) {
        case TypeExp.INT:
            System.out.println("INT");
            break;
        case TypeExp.VOID:
            System.out.println("VOID");
            break;
        default:
            System.out.println("Error unrecognized type");
        }
    }

    public void visit(FunExp exp, int level) {
        indent(level);
        System.out.println("FunExp: ");
        level++;
        exp.type.accept(this, level);
        exp.name.accept(this, level);
        if (exp.params != null) {
            indent(level);
            System.out.println("ParamsExp: ");
            level++;
            exp.params.accept(this, level);
        }
        level++;
        if (exp.compound != null) {
            level--;
            indent(level);
            System.out.println("CompoundExp: ");
            level++;
            exp.compound.accept(this, level);
        }
    }

    public void visit(ParListExp exp, int level) {
        indent(level);
        System.out.println("ParListExp: ");
        level++;
        exp.paramlist.accept(this, level);
        exp.param.accept(this, level);
    }

    public void visit(ParamExp exp, int level) {
        indent(level);
        System.out.println("ParamExp: ");
        level++;
        exp.type.accept(this, level);
        exp.name.accept(this, level);
    }

    public void visit(CompExp exp, int level) {
        indent(level);
        if (exp.first == null && exp.second == null) {
            System.out.println("Expression: Error missing values");
        } else {
            System.out.println("Expression: ");
        }
        level++;
        if (exp.first != null)
            exp.first.accept(this, level);
        if (exp.second != null)
            exp.second.accept(this, level);
    }

    public void visit(ReturnExp exp, int level) {
        indent(level);
        System.out.println("ReturnExp: ");
        level++;
        exp.exps.accept(this, level);
    }

    public void visit(MathExp exp, int level) {
        indent(level);
        switch (exp.type) {
        case MathExp.SIMPLE:
            System.out.println("SimpleExp: ");
            break;
        case MathExp.ADDITIVE:
            System.out.println("AdditiveExp: ");
            break;
        case MathExp.TERM:
            System.out.println("TermExp: ");
            break;
        default:
            System.out.println("Unrecognized statement at line " + exp.row + " and column " + exp.col);
        }
        level++;
        exp.lhs.accept(this, level);
        exp.op.accept(this, level);
        exp.rhs.accept(this, level);
    }

    public void visit(CallExp exp, int level) {
        indent(level);
        System.out.println("CallExp: ");
        level++;
        exp.name.accept(this, level);
        if (exp.args != null)
            exp.args.accept(this, level);
    }

}
