package absyn;

public class TypeExp extends Exp {
    public Object name;

    public TypeExp(int row, int col, Object name) {
        this.row = row;
        this.col = col;
        this.name = name;
    }

    public void accept(AbsynVisitor visitor, int level) {
        visitor.visit(this, level);
    }
}
