
grammar shellscript;
/*
 *  <program> ::= <statement>
 *  <statement> ::= "if" <paren_expr> <statement> |
 *                  "if" <paren_expr> <statement> "else" <statement> |
 *                  "while" <paren_expr> <statement> |
 *                  "do" <statement> "while" <paren_expr> ";" |
 *                  "{" { <statement> } "}" |
 *                  <expr> ";" |
 *                  ";"
 *  <paren_expr> ::= "(" <expr> ")"
 *  <expr> ::= <test> | <id> "=" <expr>
 *  <test> ::= <sum> | <sum> "<" <sum>
 *  <sum> ::= <term> | <sum> "+" <term> | <sum> "-" <term>
 *  <term> ::= <id> | <int> | <paren_expr>
 *  <id> ::= "a" | "b" | "c" | "d" | ... | "z"
 *  <int> ::= <an_unsigned_decimal_integer>
*/
program
   : statement +
   ;

statement
   : ifexpression
   | functionexpression
   | localexpression
   | expr
   | Comments
   | SEMI
   ;

functionexpression : Identifier '(' ')' '{' statement* '}';

ifexpression : 'if' '[' conditionexpression ']' ';' 'then' statement 'else' statement 'fi';

conditionexpression: Identifier Doublequotede;

expr  :  Doublequotede | Dollarexp?Identifier | Identifier '='  expr  ;

// (DOLLAR)? (LC)? Identifier (RC)? |

localexpression: 'local' expr '\r\n'?;


//Doublequotede : '"' (Dollarexp '{' Identifier '}' WS*)+ '"' '\r\n'?;
Doublequotede : '"' (~[\r\n"] | '""')* '"';
Identifier  : TEXT;
Comments : (COMMENT)+;
Dollarexp : DOLLAR;





LT: '<';
GT: '>';
DOT: '.';
COMMA: ',';
COLON: ':';
PLUS: '+';
MINUS: '-';

fragment DOUBLEQUOTED : '"' ;
fragment DOLLAR : '$';
//fragment IdentifierNondigit : Nondigit;
fragment TEXT  :  [a-zA-Z0-9_-]+;

/*fragment Nondigit  :   [a-zA-Z_];

fragment Digit :   [0-9];
*/

fragment COMMENT : '#' ~ [\r\n]*;

WS : [ \r\n\t] -> skip;



