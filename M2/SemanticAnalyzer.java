import absyn.*;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Set;
public class SemanticAnalyzer implements AbsynVisitor {

    HashMap<String, ArrayList<NodeType>> table;
    int globalLevel = 0;
    String type = null;
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
        exp.type.accept(this, level);
        exp.name.accept(this, level);
        if (exp.num != null)
            exp.num.accept(this, level);
        NodeType node = new NodeType(name, type, globalLevel);
        insert(node);

    }

    public void visit(IfExp exp, int level) {
        exp.test.accept(this, level);
        globalLevel++;
        exp.thenpart.accept(this, level);
        deleteLevel(globalLevel);
        if (exp.elsepart != null) {
            exp.elsepart.accept(this, level);
        }
        deleteLevel(globalLevel);

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
        if (exp.test != null) {
            exp.test.accept(this, level);
        }
        globalLevel++;
        if (exp.exps != null)
            exp.exps.accept(this, level);
        deleteLevel(globalLevel);
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
            System.out.println("Error unrecognized type");
        }
    }

    public void visit(FunExp exp, int level) {
        exp.type.accept(this, level);
        exp.name.accept(this, level);
        if (exp.params != null) {
            exp.params.accept(this, level);
        }
        globalLevel++;
        if (exp.compound != null) {
            exp.compound.accept(this, level);
        }
        deleteLevel(globalLevel);
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
    }

    public void visit(MathExp exp, int level) {
        exp.lhs.accept(this, level);
        exp.op.accept(this, level);
        exp.rhs.accept(this, level);
    }

    public void visit(CallExp exp, int level) {
        exp.name.accept(this, level);
        if (exp.args != null)
            exp.args.accept(this, level);
    }

}
