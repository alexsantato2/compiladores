/*
  Exercicio 3g - Contador de Elementos em C
  Este programa conta algumas estruturas de um arquivo .c,
  usando a logica fornecida
*/

%option noyywrap
%{
// Contadores para cada item
int contagem_reservadas = 0;
int contagem_tipos = 0;
int contagem_numeros = 0;
int contagem_especiais = 0;
%}

%%

// Conta tipos seguidos de espaço, tab ou '*'
(char|double|int|float|void)[ \t*]+ { 
    contagem_tipos++; 
}

// Conta palavras-chave seguidas de espaço e '('
(if|while|switch)[ \t]\( { 
    contagem_reservadas++; 
}

// Conta os caracteres especiais
"!"|"@"|"&"|"|"|"%"|"$"|"#" { 
    contagem_especiais++; 
}

// Conta sequecias de digitos
[0-9]+ { 
    contagem_numeros++; 
}

// Ignora espaços, tabs e quebras de linha
[ \t\r\n] {}

// Ignora o resto
. {}

%%

int main(int argc, char **argv) {
    // É preciso passar um nome de arquivo para o programa rodar
    if (argc <= 1) {
        return 1;
    }

    if (!(yyin = fopen(argv[1], "r"))) {
        perror(argv[1]); // Mostra erro se não conseguir abrir o arquivo
        return 1;
    }

    yylex(); // Roda o flex

    // Mostra o resultado final da contagem
    printf("Palavras reservadas: %d\n", contagem_reservadas);
    printf("Tipos de dados: %d\n", contagem_tipos);
    printf("Números inteiros: %d\n", contagem_numeros);
    printf("Caracteres especiais: %d\n", contagem_especiais);

    return 0;
}
