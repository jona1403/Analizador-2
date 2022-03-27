%lex

%options case-insensitive

%%

//Palabras reservadas


"Int"               return 'INT';
"Double"            return 'DOUBLE';
"Boolean"           return 'BOOLEAN';
"Char"              return 'CHAR';
"String"            return 'STRING';
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



//Expresiones regulares
[ \r\t\n]+            {}
//Comentario multilinea
\/\*([^\"])*\*\/      {}
//Comentario unilinea
(\/)(\/)(.)*          {}



//Operadores relacionales
\=\=                   return 'RELIGUAL';
\!\=                   return 'RELDIFERENCIA';
\<                     return 'RELMENOR';
\<\=                   return 'RELMENORIGUAL';
\>                     return 'RELMAYOR';
\>\=                   return 'RELMAYORIGUAL';

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
[0-9]+\b               return 'RENTERO';
[0-9]+(\.[0-9]+)?\b    return 'RDECIMAL';
[A-Za-z0-9_-]          return 'RCARACTER';
(true|1)               return 'RTRUE';
(false|0)              return 'RFALSE';
\"([^\"|^\\]|\^|\\\"|\\\\|\\n|\\t|\\\')?\"        	return 'RSTRING';
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

%left  'RDIVISION' 'RMULTIPLICACION'
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
	: instruccion instrucciones
	| instruccion
	| error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

instruccion
	: INT STRING expresion CORDER PTCOMA {
		console.log('El valor de la expresión es: ' + $3);
	}
;

expresion
	: expresion RMAS expresion       { $$ = $1 + $3; }
	| expresion RMENOS expresion     { $$ = $1 - $3; }

	| RENTERO                        { $$ = Number($1); }
	| RDECIMAL                       { $$ = Number($1); }
;