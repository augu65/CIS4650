import absyn.*;

public class ShowTreeVisitor implements AbsynVisitor {

  final static int SPACES = 4;

  private void indent(int level) {
    for (int i = 0; i < level * SPACES; i++)
      System.out.print(" ");
  }

  public void visit(ExpList expList, int level) {
    while (expList != null) {
      expList.head.accept(this, level);
      expList = expList.tail;
    }
  }

  public void visit(AssignExp exp, int level) {
    indent(level);
    System.out.println("AssignExp:");
    level++;
    exp.type.accept(this, level);
    exp.name.accept(this, level);
    if (exp.num != null)
      exp.num.accept(this, level);
  }

  public void visit(IfExp exp, int level) {
    indent(level);
    System.out.println("IfExp:");
    level++;
    exp.test.accept(this, level);
    exp.thenpart.accept(this, level);
    if (exp.elsepart != null)
      exp.elsepart.accept(this, level);
  }

  public void visit(IntExp exp, int level) {
    indent(level);
    System.out.println("IntExp: " + exp.value);
  }

  public void visit(OpExp exp, int level) {
    indent(level);
    System.out.print("OpExp:");
    switch (exp.op) {
      case OpExp.PLUS:
        System.out.println(" + ");
        break;
      case OpExp.MINUS:
        System.out.println(" - ");
        break;
      case OpExp.TIMES:
        System.out.println(" * ");
        break;
      case OpExp.OVER:
        System.out.println(" / ");
        break;
      case OpExp.EQ:
        System.out.println(" = ");
        break;
      case OpExp.LT:
        System.out.println(" < ");
        break;
      case OpExp.GT:
        System.out.println(" > ");
        break;
      default:
        System.out.println("Unrecognized operator at line " + exp.row + " and column " + exp.col);
    }
    level++;
    exp.left.accept(this, level);
    exp.right.accept(this, level);
  }

  public void visit(ReadExp exp, int level) {
    indent(level);
    System.out.println("ReadExp:");
    exp.input.accept(this, ++level);
  }

  public void visit(RepeatExp exp, int level) {
    indent(level);
    System.out.println("RepeatExp:");
    level++;
    exp.exps.accept(this, level);
    exp.test.accept(this, level);
  }

  public void visit(VarExp exp, int level) {
    indent(level);
    System.out.println("VarExp: " + exp.name);
    if (exp.exprs != null)
      exp.exprs.accept(this, level);
  }

  public void visit(WriteExp exp, int level) {
    indent(level);
    System.out.println("WriteExp:");
    exp.output.accept(this, ++level);
  }

  public void visit(TypeExp exp, int level) {
    indent(level);
    System.out.print("TypeExp:");
    switch (exp.type) {
      case TypeExp.INT:
        System.out.println(" INT ");
        break;
      case TypeExp.VOID:
        System.out.println(" VOID ");
        break;
      default:
        System.out.println("Unrecognized type at line " + exp.row + " and column " + exp.col);
    }
  }

  public void visit(FunExp exp, int level) {
    indent(level);
    System.out.println("FunExp: ");
    level++;
    System.out.println("1");
    exp.type.accept(this, level);
    System.out.println("2");
    exp.params.accept(this, level);
    System.out.println("3");
    exp.compound.accept(this, level);
    System.out.println("4");
    exp.name.accept(this, level);
    System.out.println("5");
  }

  public void visit(ParListExp exp, int level) {
    indent(level);
    System.out.print("ParListExp: ");
    level++;
    exp.paramlist.accept(this, level);
    exp.param.accept(this, level);
  }

  public void visit(ParamExp exp, int level) {
    indent(level);
    System.out.println("ParamExp: ");
    level++;
    exp.name.accept(this, level);
    exp.type.accept(this, level);
  }

  public void visit(CompExp exp, int level) {
    indent(level);
    switch (exp.stmt) {
      case CompExp.COMP:
        System.out.println("CompExp: ");
        break;
      case CompExp.LOCDEC:
        System.out.println("LocalDeclaration: ");
        break;
      case CompExp.STMTLIST:
        System.out.println("StatementList: ");
        break;
      case CompExp.ARGLIST:
        System.out.println("ArgList: ");
        break;
      case CompExp.EXPS:
        System.out.println("Expression: ");
        break;
      default:
        System.out.println("Unrecognized statement at line " + exp.row + " and column " + exp.col);
    }
    level++;
    exp.first.accept(this, level);
    exp.second.accept(this, level);
  }

  public void visit(ReturnExp exp, int level) {
    indent(level);
    System.out.println("ReturnExp: ");
    level++;
    exp.exps.accept(this, level);
  }

  public void visit(MathExp exp, int level) {
    indent(level);
    switch (exp.type) {
      case MathExp.SIMPLE:
        System.out.println("SimpleExp: ");
        break;
      case MathExp.ADDITIVE:
        System.out.println("AdditiveExp: ");
        break;
      case MathExp.TERM:
        System.out.println("TermExp: ");
        break;
      default:
        System.out.println("Unrecognized statement at line " + exp.row + " and column " + exp.col);
    }
    level++;
    exp.lhs.accept(this, level);
    exp.rhs.accept(this, level);
    exp.op.accept(this, level);
  }

  public void visit(CallExp exp, int level) {
    indent(level);
    System.out.println("CallExp: ");
    level++;
    exp.args.accept(this, level);
    exp.name.accept(this, level);
  }

}
