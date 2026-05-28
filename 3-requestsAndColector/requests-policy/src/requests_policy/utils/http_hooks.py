from requests import Response

from requests_toolbelt.utils.dump import dump_all

def raise_for_status_hook(response: Response, *args, **kwargs):
    response.raise_for_status()

def logging_hook(response: Response, *args, **kwargs):
    data = dump_all(response)
    print(data.decode('utf-8'))