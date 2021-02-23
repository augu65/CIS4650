package absyn;

public class CallExp extends Exp {
    public VarExp name;
    public Exp args;

    public CallExp(int row, int col, VarExp name, Exp args) {
        this.row = row;
        this.col = col;
        this.name = name;
        this.args = args;
    }

    public void accept(AbsynVisitor visitor, int level) {
        visitor.visit(this, level);
    }
}
