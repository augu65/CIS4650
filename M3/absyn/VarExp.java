package absyn;

public class VarExp extends Exp {
  public String name;
  public Exp exprs;
  public int nestLevel; // 0 for global, 1 for local
  public int offset;
  // links?

  public VarExp(int row, int col, String name, Exp exprs) {
    this.row = row;
    this.col = col;
    this.name = name;
    this.exprs = exprs;
    this.def = null;
    this.info = name;
  }

  public void accept(AbsynVisitor visitor, int level, boolean isAddr) {
    visitor.visit(this, level, isAddr);
  }
}
