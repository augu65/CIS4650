import absyn.*;
import jdk.nashorn.internal.runtime.regexp.joni.constants.NodeType;

import java.util.HashMap;
import java.util.ArrayList;

public class SemanticAnalyzer implements AbsynVisitor {

    HashMap<String, ArrayList<NodeType>> table;

    public SemanticAnalyzer() {
        table = new HashMap<String, ArrayList<NodeType>>();
    }

    // methods for the table operations: insert, lookup, delete

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

}
