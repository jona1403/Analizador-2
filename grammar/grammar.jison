%lex

%options case-insensitive

%%

//Palabras reservadas


"Int"               return 'INT';
"Double"            return 'DOUBLE';
"Boolean"           return 'BOOLEAN';
"Char"              return 'CHAR';
"String"            return 'STRING';
"new"				return 'NEW';
"void"              return 'VOID';
"if"                return 'IF';
"else"              return 'ELSE';
"switch"            return 'SWITCH';
"case"              return 'CASE';
"default"           return 'DEFAULT';
"break"             return 'BREAK';
"while"             return 'WHILE';
"for"               return 'FOR';
"do"                return 'DO';
"continue"          return 'CONTINUE';
"return"            return 'RETURN';
"Println"           return 'PRINTLN';
"Print"             return 'PRINT';
"toLower"           return 'TOLOWER';
"toUpper"           return 'TOUPPER';
"round"             return 'ROUND';
"length"            return 'LENGTH';
"typeof"            return 'TYPEOF';
"toString"          return 'TOSTRING';
"toCharArray"       return 'TOCHARARRAY';
"run"               return 'RUN';



//expresiones regulares
[ \r\t\n]+            {}
//Comentario multilinea
\/\*([^\"])*\*\/      {}
//Comentario unilinea
(\/)(\/)(.)*          {}



//Operadores relacionales

\!\=                   return 'RELDIFERENCIA';
\<\=                   return 'RELMENORIGUAL';
\<                     return 'RELMENOR';
\>\=                   return 'RELMAYORIGUAL';
\>                     return 'RELMAYOR';
\=\=                   return 'RELIGUAL';
//Operadores logicos
\|\|                   return 'ROR';
\&\&                   return 'RAND';
\!                     return 'RNOT';

//Operadores aritmetico

\%                     return 'RMODULO';
\^                     return 'RPOTENCIA';
\/                     return 'RDIVISION';
\*                     return 'RMULTIPLICACION';
\+                     return 'RMAS';
\-                     return 'RMENOS';
(\-)?[0-9]+\b               return 'RENTERO';
(\-)?[0-9]+(\.[0-9]+)?\b    return 'RDECIMAL';
(true|1)               return 'RTRUE';
(false|0)              return 'RFALSE';
\"([^\"|^\\]|\^|\\\"|\\\\|\\n|\\t|\\\')*\"        	return 'RSTRING';
\'([^\"|^\\]|\^|\\\"|\\\\|\\n|\\t|\\\')?\'			return 'RCHAR';
\{                     return 'RLLAVEIZQ';
\}                     return 'RLLAVEDER';
\(                     return 'RPARIZQ';
\)                     return 'RPARDER';
\[                     return 'RCORIZQ';
\]                     return 'RCORDER';
\;                     return 'RPTCOMA';
\,                     return 'RCOMA';
\:                     return 'DOSPT';
[A-Za-z0-9_-]+         return 'RIDENTIFICADOR';
\=                     return 'RIGUAL';


<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

%left  'RDIVISION' 'RMULTIPLICACION' 'RPOTENCIA' 'RMODULO'
%left  'RMAS' 'RMENOS'
%left  'RELIGUAL' 'RELDIFERENCIA' 'RELMENOR' 'RELMENORIGUAL' 'RELMAYOR' 'RELMAYORIGUAL'
%right 'RNOT'
%left  'RAND'
%left  'ROR'

%left 'UMENOS'


%start ini

%% /* Definición de la gramática */

ini
	: instrucciones EOF
;

instrucciones
	: instrucciones instruccion
	| instruccion
	| error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

instruccion: 
	declaravar
	| declararreglo
	| asignvar
	| IF RPARIZQ expresion RPARDER bloque instrelse
	| WHILE RPARIZQ expresion RPARDER bloque
	| DO bloque WHILE RPARIZQ expresion RPARDER RPTCOMA
	| FOR RPARIZQ instrasnfor expresion RPTCOMA expresion RPARDER bloque
	
;

instrasnfor:
	declaravar
	|  RPTCOMA
;

instrelse:
	ELSE IF RPARIZQ expresion RPARDER instrelse
	| ELSE bloque
	|
;

declaravar:
	declara_tipo declaravar_2 asign RPTCOMA
;

declaravar_2:
	declaravar_2 RCOMA RIDENTIFICADOR
	| RIDENTIFICADOR
;

asign:
	RIGUAL RPARIZQ declara_tipo RPARDER expresion 
	| RIGUAL expresion
	|
;

asignvar:
	asignvar_2 RPTOCOMA
;

asignvar_2:
	asignvar_2 RIGUAL expresion
	| expresion
;

declararreglo:
	declara_tipo RIDENTIFICADOR RCORIZQ RCORDER RCORIZQ RCORDER RIGUAL NEW declara_tipo RCORIZQ RENTERO RCORDER RCORIZQ RENTERO RCORDER RPTCOMA
	| declara_tipo RIDENTIFICADOR RCORIZQ RCORDER RIGUAL NEW declara_tipo RCORIZQ RENTERO RCORDER RPTCOMA
	| declara_tipo RIDENTIFICADOR RCORIZQ RCORDER RCORIZQ RCORDER RIGUAL RCORIZQ asignarray_2D RCORDER RPTCOMA
	| declara_tipo RIDENTIFICADOR RCORIZQ RCORDER RIGUAL RCORIZQ asignarray RCORDER RPTCOMA
;

asignarray_2D:
	asignarray_2D RCOMA RCORIZQ asignarray RCORDER
	| RCORIZQ asignarray RCORDER
;

asignarray:
	asignarray RCOMA expresion
	| expresion
;

declara_tipo:
	INT
	| STRING
	| CHAR
	| DOUBLE
	| BOOLEAN
	| VOID
;

expresion:
	expresion RELIGUAL expresion
	| expresion RELDIFERENCIA expresion
	| expresion RELMENOR expresion
	| expresion RELMENORIGUAL expresion
	| expresion RELMAYOR expresion
	| expresion RELMAYORIGUAL expresion
	| expresion ROR expresion
	| expresion RAND expresion
	| RNOT expresion
	| RMENOS expresion %prec UMENOS
	| expresion RMAS expresion
	| expresion RMENOS expresion
	| expresion RMULTIPLICACION expresion
	| expresion RDIVISION expresion
	| expresion RPOTENCIA expresion
	| expresion RMODULO expresion
	| RPARIZQ expresion RPARDER
	| expresion RMAS RMAS
	| expresion RMENOS RMENOS
	| RENTERO
	| RDECIMAL
	| RCHAR
	| RSTRING
	| RTRUE
	| RFALSE
	| RIDENTIFICADOR
;

bloque:
	RLLAVEIZQ instrucciones RLLAVEDER
	| RLLAVEIZQ RLLAVEDER
;