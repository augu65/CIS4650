package absyn;

public class ParListExp extends Exp {
    public Exp param;
    public Exp paramlist;

    public ParListExp(int row, int col, Exp paramlist, Exp param) {
        this.row = row;
        this.col = col;
        this.paramlist = paramlist;
        this.param = param;
    }

    public void accept(AbsynVisitor visitor, int level) {
        visitor.visit(this, level);
    }
}
