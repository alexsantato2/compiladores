/*
  Exercicio i - Tokenizador de Expressoes Aritmeticas
  Este programa le uma expressão matemática (ex: 10 * 4.5)
  e quebra a entrada em "tokens", identificando cada parte como
  numero, operador, etc.
*/

%option noyywrap
%{
// Enum para os tipos de token
enum TipoToken {
    TINTEIRO = 300,
    TFLOAT = 301,
    TSOMA = 302,
    TSUBTRACAO = 303,
    TMULTIPLICACAO = 304,
    TDIVISAO = 305,
    T_FIM_LINHA = 306
};

// Variaveis para guardar o valor dos numeros encontrados
int valorInteiro;
float valorReal;
%}

// Expressão regular de um digito
digito  [0-9]

%%

"+"         { return TSOMA; }
"-"         { return TSUBTRACAO; }
"*"         { return TMULTIPLICACAO; }
"/"         { return TDIVISAO; }

// Regra para números inteiros
{digito}+   { 
    valorInteiro = atoi(yytext); // Converte string para inteiro
    return TINTEIRO; 
}

// Regra para numeros reais (com ou sem parte decimal). Ex: 3.14 ou 7
{digito}+(\.{digito}+)? { 
    valorReal = atof(yytext); // Converte string para float
    return TREAL; 
}

\n          { return T_FIM_LINHA; }
[ \t]       {} // Ignora espaços e tabs

// Ignora qualquer outra coisa
.           { 
    printf("Caractere desconhecido: '%c'\n", *yytext); 
}

%%

int main(int argc, char **argv) {
    int tokenAtual;

    printf("Digite uma expressao matematica:\n> ");

    // Loop que pede um token ao Flex ate o fim da entrada
    while ((tokenAtual = yylex())) {
        
        switch (tokenAtual) {
            case TINTEIRO:
                printf("Token: INTEIRO | Valor = %d\n", valorInteiro);
                break;
            case TREAL:
                printf("Token: FLOAT | Valor = %f\n", valorReal);
                break;
            case TSOMA:
                printf("Token: SOMA '%s'\n", yytext);
                break;
            case TSUBTRACAO:
                printf("Token: SUBTRACAO '%s'\n", yytext);
                break;
            case TMULTIPLICACAO:
                printf("Token: MULTIPLICACAO '%s'\n", yytext);
                break;
            case TDIVISAO:
                printf("Token: DIVISAO '%s'\n", yytext);
                break;
            case T_FIM_LINHA:
                printf("Fim da Linha\n> ");
                break;
        }
    }

    printf("\nFim do programa.\n");
    return 0;
}
