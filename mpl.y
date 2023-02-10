%{
#include "stdio.h"
int result = 0;
int yylex();
int lineno;
int yywrap(void)
{
	printf("OK\n");
	return 1;
}
void yyerror()
{
	lineno+=2;
	fprintf(stderr,"syntax error\n");
}

%}
%token STR INT FLOAT
%token IF THEN ELSE WHILE FOR
%token LEFT_BRACKET RIGHT_BRACKET LEFT_SQUARE_BRACKET RIGHT_SQUARE_BRACKET 
%token LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET 
%left PLUS_OPT SUB_OPT
%left MULT_OPT DIV_OPT
%token GREATER_THAN LESS_THAN GREATER_OR_EQUAL SMALLER_OR_EQUAL NOT_EQUAL 
%token INTNUMBER FLOATNUMBER  STRING IDENTIFIER PLUS_OPT  SUB_OPT DIV_OPT  MULT_OPT EXP_OPT
%token AND_OPT OR_OPT NOT ASSIGN INC_ASSIGN DEC_ASSIGN EQUAL 
%token COMMA SEMICOLON
%token NEWLINE
%right  EXP_OPT
%%
lines:
     | lines program
     ;

program: NEWLINE  		{ lineno++;}
	| exp  			{ lineno++;} 
	| stringexp  		{ lineno++;}
	| assignmentexp  	{ lineno++;}
	| conditionalstatement  { lineno++;}
	| forstatement 		{ lineno++;}
	| whilestatement 	{ lineno++;}
	| ifstatement 		{ lineno++;}
	;

exp: IDENTIFIER
	| INTNUMBER 
	| FLOATNUMBER
	| exp SUB_OPT exp 
	| exp PLUS_OPT exp  
	| exp DIV_OPT exp  
	| exp MULT_OPT exp  
	| exp EXP_OPT exp
    ;

variable: IDENTIFIER
		| FLOATNUMBER
		| INTNUMBER
		| STRING
		;
		
assignop: ASSIGN 
		| INC_ASSIGN
		| DEC_ASSIGN
		;

assignmentexp: IDENTIFIER assignop variable 			
			| IDENTIFIER assignop exp 
			;

stringexp: STRING 
		| stringexp  STRING 
		; 

conditionalstatement: variable GREATER_THAN variable   	
					| variable GREATER_OR_EQUAL variable    
					| variable LESS_THAN variable   
					| variable SMALLER_OR_EQUAL variable   
					| variable NOT_EQUAL variable   	
					| variable EQUAL variable   
					;

forstatement: FOR LEFT_BRACKET assignmentexp SEMICOLON  conditionalstatement SEMICOLON exp RIGHT_BRACKET THEN anystatement  
			;

whilestatement: WHILE LEFT_BRACKET conditionalstatement RIGHT_BRACKET THEN anystatement	 
			;

ifstatement: IF LEFT_BRACKET conditionalstatement RIGHT_BRACKET	THEN anystatement   
			|IF LEFT_BRACKET conditionalstatement RIGHT_BRACKET	THEN anystatement ELSE anystatement   
			;
			
anystatement: ifstatement
			| exp
			| assignmentexp
			| whilestatement
			| forstatement
			;
%%
#include "math.h"
int main(void)
{
	yyparse();
	return 0;
}
