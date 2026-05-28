from requests import PreparedRequest, Response
from requests.adapters import HTTPAdapter

DEFAULT_TIMEOUT = 5 # segundos


class TimeoutHTTPAdapter(HTTPAdapter):
    def __init__(self, *args, **kwargs) -> None:
        self.timeout = DEFAULT_TIMEOUT

        if 'timeout' in kwargs:
            self.timeout = kwargs['timeout']
            del kwargs['timeout']

        super().__init__(*args, **kwargs)
    
    def send(self, request: PreparedRequest, **kwargs) -> Response:
        timeout = kwargs.get('timeout')                 # caso pase um timeout no codigo main, o do main será prioridade, senao, vai no if
        if timeout is None:
            kwargs['timeout'] = self.timeout        # ai nesse caso vai o DEFAULT_TIMEOUT de 5seg

        return super().send(request, **kwargs)
    

