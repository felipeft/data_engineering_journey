""""
Faça um programa que cumpra três passos:
    Abra um arquivo de texto.
    Leia e exiba as três primeiras linhas.
    Adicione uma nova mensagem ao final do arquivo.
"""

with open("data/ex3.txt", "r+", encoding="utf-8") as arquivo:
    for index, linha in enumerate(arquivo):
        if index < 3:
            print(linha.strip())


with open("data/ex3.txt", "a", encoding="utf-8") as arquivo:
    arquivo.write("\nESSA É A MENSAGEM FINAL ADICIONADA AO FINAL DO ARQUIVO")

with open("data/ex3.txt", "r", encoding="utf-8") as arquivo:
    print("\n", arquivo.read())


