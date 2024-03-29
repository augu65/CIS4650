package absyn;

public class AssignExp extends Exp {
  public VarExp name;
  public Exp type;
  public IntExp num;

  public AssignExp(int row, int col, VarExp name, IntExp num, Exp type) {
    this.row = row;
    this.col = col;
    this.name = name;
    this.num = num;
    this.type = type;
  }

  public void accept(AbsynVisitor visitor, int level) {
    visitor.visit(this, level);
  }
}
