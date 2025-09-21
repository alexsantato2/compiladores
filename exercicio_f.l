// Exercicio 3f
// Desenvolva um programa que analise um texto fornecido e imprima todos os valores monetários que encontrar no formato da moeda brasileira (Real). O programa deve ser capaz de reconhecer valores como R$ 12,50, R$312,78 ou R$ 0,62.

%option noyywrap
%{
#define BUFFER_SIZE 64
#define CURRENCY_SIZE 128
char values[BUFFER_SIZE][CURRENCY_SIZE];
int n = 0;
%}

%%
"R"\$[ \t]*[0-9]+,[0-9]{2}   { strncpy(values[nvals++], yytext, CURRENCY_SIZE); }
\n                          {}
.                           {}
%%
int main(int argc, char **argv) {
    int i;

    if (argc > 1) {
	if (!(yyin = fopen(argv[1], "r"))) {
	    perror(argv[1]);
	    return 1;
	}
    }

    yylex();
    printf("Foram identificados %d valores em reais: \n", nvals);
    for (i = 0; i < n; i++)
	printf("\t<%s>\n", values[i]);

    return 0;
}
