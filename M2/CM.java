
/*
  File Name: CM.java
  To Build: 
  After the scanner, cm.flex, and the parser, cm.cup, have been created.
    javac CM.java
  
  To Run: 
    java -classpath /usr/share/java/cup.jar:. CM 1.cm

  where 1.cm is an test input file for the cm language.
*/
import java.util.Arrays;
import java.io.*;
import absyn.*;

class CM {
  public static boolean SHOW_TREE = false;
  public static boolean SHOW_SEMATIC = false;
  static public void main(String argv[]) {
    /* Start the parser */
    try {
      for (int i = 0; i < argv.length; i++) {
        if (argv[i].equals("-a")) {
          SHOW_TREE = true;
        }else if(argv[i].equals("-s")){
          SHOW_SEMATIC = true;
        }
        if(!argv[i].equals("-a") && !argv[i].equals("-s")){
          argv[0] = argv[i];
        }
      }

      parser p = new parser(new Lexer(new FileReader(argv[0])));
      Absyn result = (Absyn) (p.parse().value);
      if (SHOW_TREE && result != null) {
        System.out.println("The abstract syntax tree is:");
        ShowTreeVisitor visitor = new ShowTreeVisitor();
        result.accept(visitor, 0);
      }
      if (SHOW_SEMATIC && result !=null){
        System.out.println("The Semantic analyzer tree is:");
        SemanticAnalyzer visitor = new SemanticAnalyzer();
        result.accept(visitor, 0);
      }
    } catch (Exception e) {
      /* do cleanup here -- possibly rethrow e */
      e.printStackTrace();
    }
  }
}
