# A pratica consiste em fazer um programa que:
#     Ler Json de livros
#     transforma em csv


import json
import csv

with open("data/livros.json", "r", encoding="utf-8") as arquivo:
    livros = json.load(arquivo)
    print(livros)
    print(type(livros))
    #

# temos uma lista de dicionarios agora chamada livros, que contem o texto completo do json, simples e direto
#precisa manipular ela primeiro pra virar csv e depois converte

with open("data/jsonToCsv.csv", "w", newline='', encoding="utf-8")as arquivo:
    headers = livros[0].keys()      #somente o cabeçalho (nome, preço,...)
    writer = csv.DictWriter(arquivo, fieldnames=headers)

    #agora temos cabeçalho e linhas
    writer.writeheader()
    writer.writerows(livros)
