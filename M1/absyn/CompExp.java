package absyn;

public class CompExp extends Exp {
    public final static int COMP = 0;
    public final static int LOCDEC = 1;
    public final static int STMTLIST = 2;
    public final static int ARGLIST = 3;
    public final static int EXPS = 4;

    public Exp first;
    public Exp second;
    public int stmt;

    public CompExp(int row, int col, Exp first, Exp second, int stmt) {
        this.row = row;
        this.col = col;
        this.first = first;
        this.second = second;
        this.stmt = stmt;
    }

    public void accept(AbsynVisitor visitor, int level) {
        visitor.visit(this, level);
    }
}
