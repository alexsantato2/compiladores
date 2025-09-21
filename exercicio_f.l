/*
  Exercicio 3f - Analisador de Moeda
  
  Programa em Flex que encontra e imprime valores em Reais (R$) de um texto.
*/

%option noyywrap
%{
// --- Variaveis Globais ---

#define MAX_VALORES 64              // Limite de quantos valores podemos guardar
#define TAMANHO_VALOR 128           // Tamanho maximo da string de cada valor

char valoresArmazenados[MAX_VALORES][TAMANHO_VALOR]; // Vetor que guarda os valores encontrados
int contadorValores = 0;                             // Conta quantos valores já achamos
%}

%%

// Regra para identificar o padrão de moeda: R$ 123,45
"R"\$[ \t]*[0-9]+,[0-9]{2} {
    // Se achou, copia o texto (yytext) para o nosso vetor.
    if (contadorValores < MAX_VALORES) {
        strncpy(valoresArmazenados[contadorValores++], yytext, TAMANHO_VALOR);
    }
}

\n      {}  // Ignora quebras de linha
.       {}  // Ignora qualquer outro caractere

%%

int main(int argc, char **argv) {
    int indice;

    // Se o usuário passar um nome de arquivo, o programa tentará lê-lo.
    // Senão, a entrada será o que for digitado no terminal.
    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {
            fprintf(stderr, "Erro ao tentar abrir o arquivo '%s'\n", argv[1]);
            perror("Motivo"); // Mostra o erro específico do sistema
            return 1;
        }
    }

    yylex(); // Roda o analisador do Flex

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
