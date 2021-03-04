package absyn;

public class RepeatExp extends Exp {
  public Exp exps;
  public ExpList test;

  public RepeatExp(int row, int col, Exp exps, ExpList test) {
    this.row = row;
    this.col = col;
    this.exps = exps;
    this.test = test;
  }

  public void accept(AbsynVisitor visitor, int level) {
    visitor.visit(this, level);
  }
}
