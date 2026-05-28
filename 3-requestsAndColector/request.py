# vamo fazer uma simples requisição na api economia awesomeapi de conversao de moedas
#https://economia.awesomeapi.com.br/last/USD-BRL (cotação dolar pra real)

import requests
resposta = requests.get('https://economia.awesomeapi.com.br/last/USD-BRL').json()
print(resposta)

# o que retorna é um dicionario que tem por indice 'USDBRL' e dentro dele, outro dicionario com os valores
# queremos apenas o valor de compra (bid) e venda (ask) do dolar pro real

valor_compra = resposta['USDBRL']['bid']
valor_venda = resposta['USDBRL']['ask']

print(f"valor de compra: {valor_compra}")
print(f"valor de venda: {valor_venda}")

# Essa api é simples, mas a maioria retorna dicionarios mais complexos