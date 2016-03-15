%{
typedef union{
  char* str;
  int val;
}YYSTYPE;
//first comment to create conflict
YYSTYPE yylval;

int toASCII(char c);
//Added one comment to second repository
#undef yywrap
int yywrap(){
 return 1;
}
//added one comment to first repository
#define PROGRAM   257
#define VAR       258
#define ARRAY     259
#define OF        260
#define INTEGER   261
#define REAL      262
#define FUNCTION  263
#define PROCEDURE 264
#define BEGIN     263
#define END       264
#define IF        265
#define THEN      266
#define ELSE      267
#define WHILE     268
#define DO        269
#define NOT       270
#define ID        271
#define RELOP     272
#define NUM       273
#define ADOP      274
#define MULOP     275
#define ASOP      276

//auxiliary defs

#define ADD       1
#define SUB       2
#define AND       3
#define MUL       1
#define DIV       2
#define MOD       3
#define OR        4
#define EQ        1
#define GEQ       2
#define GT        3
#define LEQ       4
#define LT        5
#define ENDOFFILE 999
%}

delim [ \t\n]
ws {delim}+
letter [A-Za-z]
digit [0-9]
id {letter}({letter}|{digit})*
number {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
comment \{.*\}

%%
{ws}      {}
{comment} {}
"+"       {yylval.val = ADD;return(ADOP);}
"-"       {yylval.val = SUB;return(ADOP);}
and     {yylval.val = AND;return(ADOP);}
"*"       {yylval.val = MUL;return(MULOP);}
"/"       {yylval.val = DIV;return(MULOP);}
mod     {yylval.val = MOD;return(MULOP);}
or      {yylval.val = OR; return(MULOP);}
program   {return(PROGRAM);}
var       {return(VAR);}
array     {return(ARRAY);}
of        {return(OF);}
integer   {return(INTEGER);}
real      {return(REAL);}
function  {return(FUNCTION);}
procedure {return(PROCEDURE);}
begin     {return(BEGIN);}
not       {return(NOT);}
if        {return(IF);}
then      {return(THEN);}
else      {return(ELSE);}
end       {return(END);}
while     {return(WHILE);}
do        {return(DO);}
{number}  {yylval.str = yytext; return(NUM);}
{id}      {yylval.str = yytext;return(ID);}
">"       {yylval.val = GT;return(RELOP);}
"<"       {yylval.val = LT;return(RELOP);}
">="      {yylval.val = GEQ;return(RELOP);}
"<="      {yylval.val = LEQ;return(RELOP);}
"="       {yylval.val = EQ;return(RELOP);}
":="      {return(ASOP);}
"("       {return(toASCII('('));}
")"       {return(toASCII(')'));}
";"       {return(toASCII(';'));}
"."       {return(toASCII('.'));}
","       {return(toASCII(','));}
":"       {return(toASCII(':'));}
"["       {return(toASCII('['));}
"]"       {return(toASCII(']'));}
<<EOF>>   {return(ENDOFFILE);}

%%

int main(){
  int x = yylex();
  int i = 1;
  int maxlength = 15;
  while(x != ENDOFFILE){
    printf("%-12s", yytext);
    printf("   %-3d", x);
    if(yylval.val < 10 && yylval.val != 0){char str[6]; sprintf(str, "(%d)",yylval.val); printf("%-6s",str);}
    else{printf("      ");}
    if(i%4 == 0){printf("\n");}
    i++;
    x = yylex();
  }
  printf("\n");
  return 0;
}
char* charptr(){
  return yytext;
}

int toASCII(char c){
  int tempVal = c;
  return tempVal;
}
