JAVAC=javac
JFLEX=jflex

all: Token.class Lexer.class Scanner.class

%.class: %.java
	$(JAVAC) $^

Lexer.java: tiny.flex
	$(JFLEX) tiny.flex

clean:
	rm -f Lexer.java *.class *~
