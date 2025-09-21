// Exercicio 3g
// Crie um programa que receba um arquivo de código fonte na linguagem C como entrada e conte a ocorrência de elementos específicos. 
// Ao final da análise, o programa deve imprimir a quantidade total de:
// Palavras reservadas: if, while e switch.
// Caracteres especiais: !, @, &, |, %, $, e #.
// Tipos de dados: int, float, double, char e void.
// Números inteiros.

%option noyywrap
%{
int palavrasReservadas = 0;
int tipos = 0;
int numeros = 0;
int caracEsp = 0;
%}

%%
(char|double|int|float|long|void)[ \t*]+        { tipos++; }
(if|while|switch)[ \t]\(                        { palavrasReservadas++; }
"!"|"@"|"&"|"|"|"%"|"$"|"#"                 { printf("%s\n", yytext);caracEsp++; }
[0-9]+                                          { numeros++; }
[ \t\r\n]                                       {}
.                                               {}
%%
int main(int argc, char **argv) {
    if (argc > 1) {
	if (!(yyin = fopen(argv[1], "r"))) {
	    perror(argv[1]);
	    return 1;
	}
    } else {
	fprintf(stderr, "usage: %s file.c\n", argv[0]);
	exit(1);
    }

    yylex();
    printf("Foram encontradas %d palavras reservadas, \n%d caracteres especiais, \
    \n%d tipos, \n%d numero(s).\n",
	    palavrasReservadas, caracEsp, tipos, numeros);

    return 0;
}
