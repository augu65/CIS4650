package absyn;

public class ParamExp extends Exp {
    public VarExp name;
    public Exp type;

    public ParamExp(int row, int col, Exp type, VarExp name) {
        this.row = row;
        this.col = col;
        this.name = name;
        this.type = type;
        this.def = type.def;
        this.info = null;
    }

    public void accept(AbsynVisitor visitor, int level, boolean isAddr) {
        visitor.visit(this, level, isAddr);
    }
}
