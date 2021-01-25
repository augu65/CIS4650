/*
  File Name: tiny.flex
  JFlex specification for the SGML Language
*/

import java.util.ArrayList;
%%
   
%class Lexer
%type Token
%line
%column
    
%eofval{
  //System.out.println("*** Reaching end of file");
   System.err.println(" The following tags were not closed:");
  for(int i = 0; i < useStack.size(); i++){
     System.err.println(useStack.get(i));
  }
  return null;
%eofval};

%{
  private static ArrayList<String> tagStack = new ArrayList<String>();
  private static ArrayList<String> useStack = new ArrayList<String>();
  private static int flag = 0;
  // static method such as getTagName can be defined here as well
%};

/* A line terminator is a \r (carriage return), \n (line feed), or
   \r\n. */
LineTerminator = \r|\n|\r\n
   
/* White space is a line terminator, space, tab, or form feed. */
WhiteSpace = [ \t\f]
   
/* A literal integer is is a number beginning with a number between
   one and nine followed by zero or more numbers between zero and nine
   or just a zero.  */
digit = [0-9]
number = ("-"|"+")?({digit}*"."{digit}+|{digit}+"."{digit}*|{digit})+
   
/* A identifier integer is a word beginning a letter between A and
   Z, a and z, or an underscore followed by zero or more letters
   between A and Z, a and z, zero and nine, or an underscore. */
letter = [a-zA-Z]

/* a punctuaion is any symbol that is not alphanumerical. !*/
punct = [\[\]\\|/.,?><!@#$%\^&*()_+\-'\"=`~:;}{]
punctNoA = [\[\]\\|/.,?><!@#$%\^&*()_+\-\"=`~:;}{]
punctNoBrac = [\[\]\\|/.,?!@#$%\^&*()_+\-'\"=`~:;}{]
identifier = {number}*{letter}+({number}*{letter}*)*

/* Open tags are anything that has <something>*/
open = "<"({WhiteSpace}|{identifier})*{identifier}+({WhiteSpace}({identifier}|{WhiteSpace}|{punctNoBrac})*)*">"
otag = {open}+

/* Closing tags are anything that has </something>*/
close = "</"{WhiteSpace}*{identifier}+{WhiteSpace}*">"
ctag = {close}+

/* Any word that contains ' */
apostword = (({identifier}|[0-9]|{punctNoA})+"'"({identifier}|[0-9]|{punctNoA})+)+
apost = {apostword}+

/* Any word that contains a - in it.*/
hyph = ({identifier}+|[0-9]+)("-"({identifier}+|[0-9]+))+
%%
   
/*
   This section contains regular expressions and actions, i.e. Java
   code, that will be executed when the scanner matches the associated
   regular expression. */



{ctag}            { if(useStack.size() > 0){
                        String tags[] = yytext().replace("</","").replace(">","").split(" ");
                        String tagFound = "";
                        //gets rid of attributes and extract tag
                        for(int i = 0; i < tags.length; i++){
                           if(!tags[i].equals("")){
                              tagFound = tags[i];
                              break;
                           }
                        }
                        if(tagFound.toUpperCase().equals(useStack.get(useStack.size()-1).toUpperCase())){
                           String tag = useStack.get(useStack.size()-1).toLowerCase();
                           //checks special case for P
                           if(tag.equals("p")){
                              if(useStack.size()-2 >= 0){
                                 tag = useStack.get(useStack.size()-2).toLowerCase();
                              }
                           }
                           useStack.remove(useStack.size()-1);
                           //checks for relevant tags
                           if(tag.equals("doc")||tag.equals("date")||tag.equals("length")||tag.equals("text")||tag.equals("headline")||tag.equals("docno")){
                              flag --;
                              return new Token(Token.CLOSE, tagFound, yyline, yycolumn);
                           }
                        }else{
                           if(flag == useStack.size() && flag != 0){
                              System.err.println("ERROR(" + yytext() + ")");
                           }
                        } 
                     }  else{
                           if(flag == useStack.size() && flag != 0){
                              System.err.println("ERROR(" + yytext() + ")");
                           }
                     }
                  } 
{otag}            { 
                     String tags[] = yytext().replace("<","").replace(">","").split(" ");
                     String tagFound = "";
                     //gets rid of attributes and extract tag
                     for(int i = 0; i < tags.length; i++){
                        if(!tags[i].equals("")){
                           tagFound = tags[i];
                           break;
                        }
                     }
                     useStack.add(tagFound);
                     String tag = useStack.get(useStack.size()-1).toLowerCase();
                     //checks P case
                     if(tag.equals("p")){
                        if(useStack.size()-2 >= 0){
                           tag = useStack.get(useStack.size()-2).toLowerCase();
                        }
                     }
                     //checks for relevant tags
                     if(tag.equals("doc")||tag.equals("date")||tag.equals("length")||tag.equals("text")||tag.equals("headline")||tag.equals("docno")){
                        flag ++;
                        return new Token(Token.OPEN, tagFound, yyline, yycolumn); 
                     }
                  }
{apost}           { if(flag == useStack.size() && flag != 0){
                        return new Token(Token.APOSTROPHIZED, yytext(), yyline, yycolumn);
                     }
                  }
{hyph}            { if(flag == useStack.size() && flag != 0){
                        return new Token(Token.HYPHENATED, yytext(), yyline, yycolumn); 
                     }
                  }
{identifier}      { if(flag == useStack.size() && flag != 0){
                        return new Token(Token.WORD, yytext(), yyline, yycolumn); 
                     }
                  }
{number}          { if(flag == useStack.size() && flag != 0){
                        return new Token(Token.NUMBER, yytext(), yyline, yycolumn); 
                     }
                  }
{punct}           { if(flag == useStack.size() && flag != 0){
                        return new Token(Token.PUNCTUATION, yytext(), yyline, yycolumn); 
                     }
                  }
{WhiteSpace}+     { /* skip whitespace */ }  
{LineTerminator}+ { /* skips new lines */ }
.                 {  if(flag == useStack.size() && flag != 0){
                         return new Token(Token.PUNCTUATION, yytext(), yyline, yycolumn); 
                     }
                  }
 