
/*
  Created by: Fei Song
  File Name: CM.java
  To Build: 
  After the scanner, cm.flex, and the parser, cm.cup, have been created.
    javac CM.java
  
  To Run: 
    java -classpath /usr/share/java/cup.jar:. CM gcd.cm

  where gcd.cm is an test input file for the cm language.
*/
import java.util.Arrays;
import java.io.*;
import absyn.*;

class CM {
  public static boolean SHOW_TREE = false;

  static public void main(String argv[]) {
    /* Start the parser */
    try {
      for (int i = 0; i < argv.length; i++) {
        if (argv[i].equals("-a")) {
          SHOW_TREE = true;
          if (i + 1 < argv.length) {
            argv[i] = argv[i + 1];
            break;
          } else {
            argv[i] = argv[i - 1];
            break;
          }
        }
      }
      parser p = new parser(new Lexer(new FileReader(argv[0])));
      Absyn result = (Absyn) (p.parse().value);
      if (SHOW_TREE && result != null) {
        System.out.println("The abstract syntax tree is:");
        ShowTreeVisitor visitor = new ShowTreeVisitor();
        result.accept(visitor, 0);
      }
    } catch (Exception e) {
      /* do cleanup here -- possibly rethrow e */
      e.printStackTrace();
    }
  }
}
