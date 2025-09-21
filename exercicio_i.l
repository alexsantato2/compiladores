/*
  Exercicio i - Tokenizador de Expressoes Aritmeticas
  
  Este programa lê uma expressão matemática (ex: 10 * 4.5)
  e quebra a entrada em "tokens", identificando cada parte como
  número, operador, etc.
*/

%option noyywrap
%{
// Enum com nomes em português para os tipos de token
enum TipoToken {
    T_INTEIRO = 258,
    T_REAL = 259,       // "float" é uma palavra reservada em C
    T_SOMA = 260,
    T_SUBTRACAO = 261,
    T_MULTIPLICACAO = 262,
    T_DIVISAO = 263,
    T_FIM_LINHA = 264
};

// Variaveis para guardar o valor dos numeros encontrados
int valorInteiro;
float valorReal;
%}

// Apelido para a expressão regular de um dígito
digito  [0-9]

%%

"+"         { return T_SOMA; }
"-"         { return T_SUBTRACAO; }
"*"         { return T_MULTIPLICACAO; }
"/"         { return T_DIVISAO; }

// Regra para números inteiros. Ex: 42
{digito}+   { 
    valorInteiro = atoi(yytext); // Converte string para inteiro
    return T_INTEIRO; 
}

// Regra para números reais (com ou sem parte decimal). Ex: 3.14 ou 7
// O Flex sempre escolhe a regra que casa com o texto mais longo.
// Por isso, "123.45" será classificado como T_REAL.
// "123" casa com as duas regras, mas como a de T_INTEIRO vem primeiro, ela é a escolhida.
{digito}+(\.{digito}+)? { 
    valorReal = atof(yytext); // Converte string para float
    return T_REAL; 
}

\n          { return T_FIM_LINHA; }
[ \t]       {} // Ignora espaços e tabs

// Se encontrar algo que não conhece
.           { 
    // Nota: *yytext pega apenas o primeiro caractere do lexema.
    // Isso foi mantido para não alterar a lógica original.
    printf("Caractere desconhecido: '%c'\n", *yytext); 
}

%%

int main(int argc, char **argv) {
    int tokenAtual;

    printf("Digite uma expressao matematica (Ctrl+D para sair):\n> ");

    // Loop que pede um token ao Flex até o fim da entrada
    while ((tokenAtual = yylex())) {
        
        // Usando um switch para deixar a saida mais clara
        switch (tokenAtual) {
            case T_INTEIRO:
                printf("Token: INTEIRO \t| Valor = %d\n", valorInteiro);
                break;
            case T_REAL:
                printf("Token: REAL \t| Valor = %f\n", valorReal);
                break;
            case T_SOMA:
                printf("Token: SOMA '%s'\n", yytext);
                break;
            case T_SUBTRACAO:
                printf("Token: SUBTRACAO '%s'\n", yytext);
                break;
            case T_MULTIPLICACAO:
                printf("Token: MULTIPLICACAO '%s'\n", yytext);
                break;
            case T_DIVISAO:
                printf("Token: DIVISAO '%s'\n", yytext);
                break;
            case T_FIM_LINHA:
                printf("--- Fim da Linha ---\n> ");
                break;
        }
    }

    printf("\nFim do programa.\n");
    return 0;
}
