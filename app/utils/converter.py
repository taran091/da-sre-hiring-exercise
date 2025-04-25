import os
import requests
from datetime import datetime
from dotenv import load_dotenv

load_dotenv()
API_KEY = os.getenv("OXR_APP_ID")

def get_rates_for_date(epoch_seconds):
    date_str = datetime.utcfromtimestamp(epoch_seconds).strftime('%Y-%m-%d')
    url = f"https://openexchangerates.org/api/historical/{date_str}.json"
    params = {"app_id": API_KEY}
    resp = requests.get(url, params=params)
    data = resp.json()
    return data["rates"]

def convert_currency(date, from_currency, to_currency, amount):
    rates = get_rates_for_date(date)
    if from_currency not in rates or to_currency not in rates:
        raise ValueError("Invalid currency codes")
    rate = rates[to_currency] / rates[from_currency]
    converted = amount * rate
    return converted, rate
