import requests

from urllib3.util.retry import Retry

from requests_policy.configs import HTTP_DEBUG
from requests_policy.utils.http_adapters import TimeoutHTTPAdapter
from requests_policy.utils.http_hooks import (
    raise_for_status_hook,
    logging_hook
)

retry_policy = Retry(
    total=3,
    backoff_factor=1,           # fator de sucessibilidade, vai aumentando exponencialmente o tempo entre uma requisicção e outra (tentativas)
    status_forcelist=[429, 500, 502, 503, 504],
    allowed_methods=["HEAD", "GET", "POST", "PUT", "DELETE", "OPTIONS", "TRACE"]
)

adapter = TimeoutHTTPAdapter(max_retries=retry_policy)

http = requests.Session()
http.mount('http://', adapter)
http.mount('https://', adapter)
http.hooks["response"] = [raise_for_status_hook]

if HTTP_DEBUG:
    http.hooks["response"].append(logging_hook)