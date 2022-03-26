%lex

%options case-insensitive

%%

//Palabras reservadas

//Expresiones regulares
[ \r\t\n]+            {}
//Comentarios unilinea y multilinea


<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex