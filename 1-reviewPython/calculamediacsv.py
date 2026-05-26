def average_column(csv_path):
    # O comando 'with' abre o arquivo e garante que ele será fechado automaticamente no final
    with open(csv_path, "r") as f:
        total_sum = 0
        element_count = 0  #  conta quantos números de fato existem
        
        for row in f:
            # strip() remove quebras de linha (\n) que ficam no final de cada linha do arquivo
            # split(',') divide a linha toda vez que encontrar uma vírgula
            for column in row.strip().split(','):
                
                # garante que não vai tentar converter strings vazias em float
                if column: 
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
