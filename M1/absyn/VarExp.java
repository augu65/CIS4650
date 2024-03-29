package absyn;

public class VarExp extends Exp {
  public String name;
  public Exp exprs;

  public VarExp(int row, int col, String name, Exp exprs) {
    this.row = row;
    this.col = col;
    this.name = name;
    this.exprs = exprs;
  }

  public void accept(AbsynVisitor visitor, int level) {
    visitor.visit(this, level);
  }
}
