# usando imports da propria api pra "testar"

import openmeteo_requests
import pandas as pd
import requests_cache
import csv
import json
from retry_requests import retry

# Setup the Open-Meteo API client with cache and retry on error
cache_session = requests_cache.CachedSession('.cache', expire_after = 3600)
retry_session = retry(cache_session, retries = 5, backoff_factor = 0.2)
openmeteo = openmeteo_requests.Client(session = retry_session)

url = "https://api.open-meteo.com/v1/forecast"
params = {
	"latitude": -4.971898,
	"longitude": -39.022141,
	"hourly": "temperature_2m",
}
responses = openmeteo.weather_api(url, params = params)

response = responses[0]
print(f"Coordinates: {response.Latitude()}°N {response.Longitude()}°E")
print(f"Elevation: {response.Elevation()} m asl")
print(f"Timezone difference to GMT+0: {response.UtcOffsetSeconds()}s")

hourly = response.Hourly()
hourly_temperature_2m = hourly.Variables(0).ValuesAsNumpy()

hourly_data = {
	"date": pd.date_range(
		start = pd.to_datetime(hourly.Time(), unit = "s", utc = True),
		end =  pd.to_datetime(hourly.TimeEnd(), unit = "s", utc = True),
		freq = pd.Timedelta(seconds = hourly.Interval()),
		inclusive = "left"
	)
}

hourly_data["temperature_2m"] = hourly_temperature_2m

hourly_dataframe = pd.DataFrame(data = hourly_data)
print("\nHourly data\n", hourly_dataframe)

print(type(hourly_dataframe))



## conversao do hourly_dataframe para uma lista com nomes das colunas 
# [['date' 'temperature_2m], [000000]]

df = pd.DataFrame(hourly_dataframe)
li = [df.columns.values.tolist()] + df.values.tolist()
print(li)
print(type(li))

## convertendo agora essa lista para csv

with open("/home/felipe/Desktop/data_engineering_journey/data/climaQuixada_06_02.csv", "w", newline='', encoding="utf-8")as arquivo:
    writer = csv.writer(arquivo)
    writer.writerows(li)


#agora para json
# para json é necessario converter o timestamp para datetime



with open("/home/felipe/Desktop/data_engineering_journey/data/climaQuixada_06_02.json", "w", encoding="utf-8")as arquivo:
    json.dump(li, arquivo, default=str, indent=4)

