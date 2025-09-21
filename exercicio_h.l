/*
  Exercicio h - Analisador Simples de SQL
  
  Este programa identifica as palavras-chave SELECT, FROM e WHERE
  e também os identificadores (nomes de tabelas/colunas) em uma
  expressão SQL digitada no terminal.
*/

// Opções do Flex:
// noyywrap: simplifica a compilação.
// case-insensitive: faz com que "select", "SELECT", "Select", etc., sejam tratados como iguais.
%option noyywrap case-insensitive

%{
// Enum para dar nomes aos nossos tokens. Os números são arbitrários.
enum TipoToken {
    TOKEN_SELECT = 258,
    TOKEN_FROM = 259,
    TOKEN_WHERE = 260,
    TOKEN_IDENTIFICADOR = 261,
    TOKEN_FIM_DE_LINHA = 262
};

// Apenas a declaração da nossa função que vai lidar com os identificadores.
void processaIdentificador(char *textoId);
%}

// Definindo um apelido para nossa expressão regular de um identificador.
// Começa com uma letra, seguida por letras, números ou _.
identificador   [A-Za-z][A-Za-z0-9_]+

%%

"select"        { return TOKEN_SELECT; }
"from"          { return TOKEN_FROM; }
"where"         { return TOKEN_WHERE; }
{identificador} { return TOKEN_IDENTIFICADOR; }
\n              { return TOKEN_FIM_DE_LINHA; }

[ \t]+          {} // Ignora espaços e tabs
.               {} // Ignora qualquer outra coisa (virgulas, asteriscos, etc)

%%

// Função chamada quando um identificador é encontrado.
// No mundo real, aqui você adicionaria o ID a uma tabela de símbolos.
void processaIdentificador(char *textoId) {
    char copiaId[256];
    
    // Apenas copia o texto e imprime uma mensagem.
    strncpy(copiaId, textoId, 256);
    printf(" -> identificador encontrado: \"%s\"\n", copiaId);
}

int main(int argc, char **argv) {
    int tokenAtual;

    printf("Digite uma expressao SQL e pressione Enter (Ctrl+D para sair):\n");

    // Loop principal: yylex() é chamado repetidamente.
    // Ele retorna o próximo token encontrado ou 0 no fim da entrada.
    while ((tokenAtual = yylex())) {
        
        // Imprime o código numérico do token que foi encontrado.
        printf("%d", tokenAtual);

        // Se o token for um identificador, chama nossa função auxiliar.
        if (tokenAtual == TOKEN_IDENTIFICADOR) {
            processaIdentificador(yytext);
        } else {
            // Para outros tokens, apenas pula uma linha.
            printf("\n");
        }
    }

    return 0;
}
