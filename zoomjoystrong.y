%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
        void yyerror(const char* msg);
        int yylex();
	void circleMaker(int x, int y, int r);
	void rectangleMaker(int x, int y, int w, int h);
	void colorChanger(int r, int g, int b);
%}

%error-verbose
%union {int i; float f;}
%start statement

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT
%token WHITE_SPACE

%type<i> INT
%type<f> FLOAT

%%
statement: newType
	| newType statement
;

newType: newLine
       	| newPoint
	| newCircle
	| newRectangle
	| newColor
;

/*number: INT
      | FLOAT
;*/

newLine: LINE INT INT INT INT END_STATEMENT 
        {line($2, $3, $4, $5);}
;

newPoint: POINT INT INT END_STATEMENT
	{point($2, $3);}
;

newCircle: CIRCLE INT INT INT END_STATEMENT
	{circleMaker($2, $3, $4);}
;

newRectangle: RECTANGLE INT INT INT INT END_STATEMENT
	{rectangleMaker($2, $3, $4, $5);}
;

newColor: SET_COLOR INT INT INT END_STATEMENT
	{colorChanger($2, $3, $4);}
;
%%

int main(int arc, char** argv){
	setup();
	yyparse();
	finish();
	return 0;	
}



void yyerror(const char* msg){
        fprintf(stderr, "ERROR! %s\n", msg);
}

void colorChanger(int r, int g, int b){
	if(r > 256 || r < 0){
		yyerror("Give a valid color value for red.");
	}
	else if(g > 256 || g < 0){
                yyerror("Give a valid color value for green.");
        }
	else if(b > 256 || b < 0){
                yyerror("Give a valid color value for blue.");
        }
	else{
		set_color(r, g, b);
	}
}

void rectangleMaker(int x, int y, int w, int h){
	if(w == 0){
		yyerror("You can't have a width of 0.");
	}
	else if(h == 0){
                yyerror("You can't have a height of 0.");
        }
	else{
		rectangle(x, y, w, h);
	}
}

void circleMaker(int x, int y, int r){
	if(r == 0){
                yyerror("You can't have a radius of 0.");
        }
}

