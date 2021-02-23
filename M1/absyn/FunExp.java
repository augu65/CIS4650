package absyn;

public class FunExp extends Exp {
    public VarExp name;
    public Exp type;
    public Exp params;
    public Exp compound;

    public FunExp(int row, int col, Exp type, VarExp name, Exp params, Exp compound) {
        this.row = row;
        this.col = col;
        this.name = name;
        this.type = type;
        this.compound = compound;
    }

    public void accept(AbsynVisitor visitor, int level) {
        visitor.visit(this, level);
    }
}
