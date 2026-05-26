import csv


def average_numbers(csv_path):
    total_sum = 0.0
    element_count = 0.0

    with open(csv_path, mode="r", encoding="utf-8") as file:    # utf-8 por conta dos acentos 

        csv_reader = csv.reader(file)

        for row in csv_reader:
            for cell in row:

                # limpando valores que podem haver la em reais
                clean_cell = cell.strip().replace('R$', '').replace(' ', '')
                clean_cell = clean_cell.replace('.', '').replace(',', '.')

                # a ideia é utilizar EAFP ("é mais facil pedir perdão do que permissao")
                # em vez de checar célula por célula, espera o erro do python de que é string
                # daí pega esse erro, e simplesmente ignora a celula (segue em frente pae)
                
                try:                            # O codigo tenta, mas quando for string vai dar erro
                    value = float(clean_cell)
                    total_sum += value
                    element_count += 1

                except ValueError:
                    # tratamento do erro que deu anteriomente quando for string
                    continue

        if element_count == 0:
            return "Não tinha valores numéricos na planilha"
        
        return total_sum / element_count
    
csv_file = "/home/felipe/Desktop/data_engineering_journey/data/Financeiro Familiar 2026 - Valores.csv"
print(f"{average_numbers(csv_file):.2f}")

# no contexto do csv, esse numero impresso nao quer dizer absolutamente nada, mas ta ai

