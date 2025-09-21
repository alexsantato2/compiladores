/*
  Exercicio 3f - Analisador de Moeda
  Programa em Flex que encontra e imprime valores em Reais (R$) de um texto.
*/

%option noyywrap
%{
// Variaveis globais
#define MAX_VALORES 100 // Quantos valores podemos guardar
#define TAMANHO_VALOR 100 // Tamanho maximo da string de cada valor

char valoresArmazenados[MAX_VALORES][TAMANHO_VALOR]; // Vetor que guarda os valores encontrados
int contadorValores = 0; // Conta quantos valores a gente ja achou
%}

%%

// Como identificar o padrão de moeda: R$ 123,45
"R"\$[ \t]*[0-9]+,[0-9]{2} {
    // Se achou, copia o texto para o vetor
    if (contadorValores < MAX_VALORES) {
        strncpy(valoresArmazenados[contadorValores++], yytext, TAMANHO_VALOR);
    }
}

\n      {}  // Ignora quebras de linha
.       {}  // Ignora qualquer outro caractere

%%

int main(int argc, char **argv) {
    int indice;

    // Le o arquivo passado pelo terminal
    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {
            fprintf(stderr, "Erro ao tentar abrir o arquivo '%s'\n", argv[1]);
            return 1;
        }
    }

    yylex(); // Roda o analisador do flex

    // Imprime o resultado final
    if (contadorValores > 0) {
        printf("\nForam encontrados %d valores monetarios:\n", contadorValores);
        for (indice = 0; indice < contadorValores; indice++) {
            printf("  -> %s\n", valoresArmazenados[indice]);
        }
    } else {
        printf("\nNenhum valor monetario foi encontrado.\n");
    }

    return 0;
}
