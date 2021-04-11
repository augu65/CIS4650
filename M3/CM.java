
/*
  File Name: CM.java
  To Build: 
  After the scanner, cm.flex, and the parser, cm.cup, have been created.
    javac CM.java
  
  To Run: 
    java -classpath /usr/share/java/cup.jar:. CM 1.cm

  where 1.cm is an test input file for the cm language.
*/
import java.io.*;
import absyn.*;

class CM {
  public static boolean SHOW_TREE = false;
  public static boolean SHOW_SEMATIC = false;
  public static boolean SHOW_GENERATE = false;

  static public void main(String argv[]) {
    /* Start the parser */
    try {
      for (int i = 0; i < argv.length; i++) {
        if (argv[i].equals("-a")) {
          SHOW_TREE = true;
        } else if (argv[i].equals("-s")) {
          SHOW_SEMATIC = true;
        } else if (argv[i].equals("-c")) {
          SHOW_GENERATE = true;
        }
        if (!argv[i].equals("-a") && !argv[i].equals("-s") && !argv[i].equals("-c")) {
          argv[0] = argv[i];
        }
      }
      if (!SHOW_TREE && !SHOW_SEMATIC && !SHOW_GENERATE) {
        System.out.println("Please add the -a flag for the abstract syntax tree.");
        System.out.println("Please add the -s flag for the symantic analyzer tree.");
        System.out.println("Please add the -c flag to generate assembly code.");
        return;
      }
      parser p = new parser(new Lexer(new FileReader(argv[0])));
      Absyn result = (Absyn) (p.parse().value);
      if (SHOW_TREE && result != null) {
        PrintStream out = new PrintStream(new FileOutputStream(argv[0].replace(".cm", "") + ".abs"));
        System.setOut(out);
        System.out.println("The abstract syntax tree is:");
        ShowTreeVisitor visitor = new ShowTreeVisitor();
        result.accept(visitor, 0, false);
      }
      if (SHOW_SEMATIC && result != null) {
        System.out.flush();
        PrintStream out = new PrintStream(new FileOutputStream(argv[0].replace(".cm", "") + ".sym"));
        System.setOut(out);
      }else{
        PrintStream out =new PrintStream(new FileOutputStream("/dev/null"));
        System.setOut(out);
      }
      System.out.println("The Semantic analyzer tree is:");
      System.out.println("Entering the global scope:");
      SemanticAnalyzer visitor = new SemanticAnalyzer();
      NodeType node = new NodeType("input", "(VOID) -> INT", 0, 0);
      visitor.insert(node);
      NodeType node2 = new NodeType("output", "(INT) -> VOID", 0, 0);
      visitor.insert(node2);
      result.accept(visitor, 0, false);
      visitor.printLevel(0);
      System.out.println("Leaving the global scope");
      if (SHOW_GENERATE && result != null) {
        PrintStream out = new PrintStream(new FileOutputStream(argv[0].replace(".cm", "") + ".tm"));
        System.setOut(out);
        codeGenerator visitor2 = new codeGenerator();
        visitor2.emitComment("C-Minus Compilation to TM Code");
        visitor2.emitComment("File: " + argv[0].replace(".cm", "") + ".tm");
        visitor2.visit(result, visitor2);
      }
    } catch (Exception e) {
      /* do cleanup here -- possibly rethrow e */
      e.printStackTrace();
    }
  }
}
