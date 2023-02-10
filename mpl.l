%{
#include "stdio.h"
#include "y.tab.h"
extern int yylval;
%}
%%
"int" 					{return INT;}
"flt" 					{return FLOAT;}
"string" 				{return STR ;}
"if" 					{return IF;}
"then" 					{return THEN;}
"else" 					{return ELSE;} 
"while" 				{return WHILE;}
"for" 					{return FOR;}
"and"					{return AND_OPT;}
"or"					{return OR_OPT;}
"\!" 					{return NOT;}
"\=" 					{return ASSIGN;}
"\+=" 					{return INC_ASSIGN;}
"\-=" 					{return DEC_ASSIGN;}
"\==" 					{return EQUAL;}
"\("					{return LEFT_BRACKET;}
"\)" 					{return RIGHT_BRACKET;}
"\[" 					{return LEFT_SQUARE_BRACKET;}
"\]" 					{return RIGHT_SQUARE_BRACKET;}
"\{" 					{return LEFT_CURLY_BRACKET;}
"\}" 					{return RIGHT_CURLY_BRACKET;}
"\>=" 					{return GREATER_OR_EQUAL;}
"\<=" 					{return SMALLER_OR_EQUAL;}
"\^" 					{return EXP_OPT;}
"\>" 					{return GREATER_THAN;}
"\<" 					{return LESS_THAN;}	
"\;"					{return SEMICOLON;}
"\," 					{return COMMA;}
"+" 					{return PLUS_OPT;}
"\-" 					{return SUB_OPT;}
"\/" 					{return DIV_OPT;}
"\*" 					{return MULT_OPT;}
"\!=" 					{return NOT_EQUAL;}
\"(.)*\" 				{return STRING;}
[+-]?[0-9]+  				{return INTNUMBER;}
[+-]?[0-9]*(\.)?[0-9]+ 			{return FLOATNUMBER;}
[a-zA-Z]([a-zA-Z]|[0-9])* 		{return IDENTIFIER;}
"\\n"					{extern int lineno; lineno++;	return NEWLINE;}
[\t ]+					{;}
%%
