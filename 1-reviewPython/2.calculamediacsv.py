def average_column(csv_path):
    # O comando 'with' abre o arquivo e garante que ele será fechado automaticamente no final
    with open(csv_path, "r") as f:
        total_sum = 0
        element_count = 0  #  conta quantos números de fato existem
        

        # como que se percorre uma matriz?
        # R: dois laços de repetição onde percorre as linhas e valores respectivamente
        # ex:
        # matriz = [
        #     [10, 20, 30],
        #     [40, 50, 60],
        #     [70, 80, 90]

        # soma_total = 0
        # quantidade_elementos = 0

        # for linha in matiz:
        #     for numero in linha:
        #         soma_total += numero
        #         quantidade_elementos += 1
        #vamos segui mais ou menos o mesmo principio aqui

        for row in f:   # "f" foi como chamamos o csv la em cima no with
            # strip() remove quebras de linha (\n) que ficam no final de cada linha do arquivo
            # split(',') divide a linha toda vez que encontrar uma vírgula
            for column in row.strip().split(','):
                
                # garante que não vai tentar converter strings vazias em float
                if column: # if column nao for vazia...
                    n = float(column)
                    total_sum += n
                    element_count += 1
                    
        # evita erro de divisão por zero caso o arquivo esteja vazio
        if element_count == 0:
            return "O arquivo está vazio ou não contém números válidos."
            
        average = total_sum / element_count
        
    return 'A media é:', average

csv = "/home/felipe/Desktop/data_engineering_journey/data/Financeiro Familiar 2026 - Valores.csv"
print(average_column(csv))
