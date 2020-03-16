%{	
	#include <stdlib.h>
	#include "zoomjoystrong.tab.h"
	//Need the noyywrap option, or else need to include -lfl in the clang to use the base yywrap
%}
%option noyywrap

%%
[0-9]+          	{yylval.i = atoi(yytext); return INT;}
[0-9]+\.[0-9]           {yylval.f = atoi(yytext); return FLOAT;}
\-[0-9]+                {printf("You can't have negative integers.");}
\-[0-9]+\.[0-9]         {printf("You can't have negative floats.");}
point			{return POINT;}
line			{return LINE;}
circle			{return CIRCLE;}
set_color		{return SET_COLOR;}
rectangle		{return RECTANGLE;}
[ \t\s\n\r]     ;
;			{return END_STATEMENT;}
			
%%
