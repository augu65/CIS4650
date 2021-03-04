package absyn;

public interface AbsynVisitor {

  public void visit(ExpList exp, int level);

  public void visit(AssignExp exp, int level);

  public void visit(IfExp exp, int level);

  public void visit(IntExp exp, int level);

  public void visit(OpExp exp, int level);

  public void visit(RepeatExp exp, int level);

  public void visit(VarExp exp, int level);

  public void visit(TypeExp exp, int level);

  public void visit(FunExp exp, int level);

  public void visit(ParListExp exp, int level);

  public void visit(ParamExp exp, int level);

  public void visit(CompExp exp, int level);

  public void visit(ReturnExp exp, int level);

  public void visit(MathExp exp, int level);

  public void visit(CallExp exp, int level);

}
