import requests

from requests_policy.utils.http import http
from requests_policy.configs import HTTP_BIN_URL

def start() -> None:
    response = http.get(f'{HTTP_BIN_URL}/status/200')

    print(response.status_code)

# implementação da politica de retry quando um parceiro responder com uma classe de status http
# isso garante que vai fazer a retentativa para nao desistir de primeira