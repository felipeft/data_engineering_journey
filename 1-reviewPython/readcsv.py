import csv

# Impressao do csv completo
with open('data/Financeiro Familiar 2026 - Valores.csv', newline='') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
    for row in spamreader:
        print(', '.join(row)) # separaçao com , das linhas vazias entre as preenchidas


print('\n')