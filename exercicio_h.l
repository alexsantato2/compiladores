/*
  Exercicio h - Analisador de SQL
  Programa identifica as palavras-chave SELECT, FROM e WHERE
  e também os identificadores (nomes de tabelas/colunas) em uma
  expressão SQL digitada no terminal.
*/

// case-insensitive: despreza diferenca de maiusculo e minusculo
%option noyywrap case-insensitive

%{
// Enum para dar nomes aos tokens
enum TipoToken {
    TOKEN_SELECT = 1,
    TOKEN_FROM = 2,
    TOKEN_WHERE = 3,
    TOKEN_IDENTIFICADOR = 4,
    TOKEN_FIM_DE_LINHA = 5
};

void processaIdentificador(char *textoId);
%}

// Apelido para expressao regular de identificador
// Começa com uma letra, seguida por letras, números ou _.
identificador   [A-Za-z][A-Za-z0-9_]+

%%

"select"        { return TOKEN_SELECT; }
"from"          { return TOKEN_FROM; }
"where"         { return TOKEN_WHERE; }
{identificador} { return TOKEN_IDENTIFICADOR; }
\n              { return TOKEN_FIM_DE_LINHA; }

[ \t]+          {} // Ignora espaços e tabs
.               {} // Ignora outra coisa

%%

// Função chamada quando um identificador eh encontrado
void processaIdentificador(char *textoId) {
    char copiaId[256];
    
    // Copia e imprime mensagem (por ser ponteiro)
    strncpy(copiaId, textoId, 256);
    printf(" -> identificador encontrado: \"%s\"\n", copiaId);
}

int main(int argc, char **argv) {
    int tokenAtual;

    printf("Digite uma expressao SQL e pressione Enter:\n");

    // yylex() é chamado repetidamente
    // Retorna o proximo token encontrado ou 0 no fim da entrada
    while ((tokenAtual = yylex())) {
        
        // Imprime o codigo numerico do token que foi encontrado
        printf("%d", tokenAtual);

        // Se o token for um identificador, chama nossa função auxiliar
        if (tokenAtual == TOKEN_IDENTIFICADOR) {
            processaIdentificador(yytext);
        } else {
            // Para outros tokens, pula uma linha
            printf("\n");
        }
    }

    return 0;
}
