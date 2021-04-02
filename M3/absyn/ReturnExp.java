package absyn;

public class ReturnExp extends Exp {
    public Exp exps;

    public ReturnExp(int row, int col, Exp exps) {
        this.row = row;
        this.col = col;
        this.exps = exps;
    }

    public void accept(AbsynVisitor visitor, int level) {
        visitor.visit(this, level);
    }
}
