package absyn;

public class OpExp extends Exp {
  public final static int PLUS = 0;
  public final static int MINUS = 1;
  public final static int TIMES = 2;
  public final static int OVER = 3;
  public final static int EQ = 4;
  public final static int LT = 5;
  public final static int GT = 6;
  public final static int LE = 7;
  public final static int GE = 8;
  public final static int NEQ = 9;
  public final static int ERROR = 10;
  public int op;

  public OpExp(int row, int col, int op) {
    this.row = row;
    this.col = col;
    this.op = op;
  }

  public void accept(AbsynVisitor visitor, int level) {
    visitor.visit(this, level);
  }
}
