import csv

# Impressao do csv completo
with open('data/Financeiro Familiar 2026 - Valores.csv', newline='') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')      # funçao de leitura de csv chamada reader
    for row in spamreader:      # row e uma lista para cada elemento de spamreader
        print(', '.join(row)) # separaçao com , das linhas vazias entre as preenchidas


    print('\n')

    print(type(row))