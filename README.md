Instalando ferramentas:
sudo apt-get install flex build-essential

Gerar codigo C com o flex:
flex exercicio_x.l

Compilar codigo C com o GCC:
gcc lex.yy.c -o analisador_x

Executando programas:
./analisador_x teste.txt
