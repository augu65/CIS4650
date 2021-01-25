/*
File Name: Scanner.java
Scanner for the SGML language
*/
import java.io.InputStreamReader;

/*
This class holds all the scanner information
*/
public class Scanner {
  private Lexer scanner = null;

  public Scanner(Lexer lexer) {
    scanner = lexer;
  }
  // loops through the tokens
  public Token getNextToken() throws java.io.IOException {
    return scanner.yylex();
  }

  //calls the flex functions and creates the scanner
  public static void main(String argv[]) {
    try {
      Scanner scanner = new Scanner(new Lexer(new InputStreamReader(System.in)));
      Token tok = null;
      while ((tok = scanner.getNextToken()) != null)
        System.out.println(tok);
    } catch (Exception e) {
      System.err.println("Unexpected exception: "+e);
    }
  }
}
