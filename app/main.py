from fastapi import FastAPI, HTTPException
from prometheus_client import Gauge, generate_latest
from fastapi.responses import Response
from utils.converter import get_rates_for_date, convert_currency
import time

app = FastAPI()

# Prometheus metric setup
conversion_gauge = Gauge('conversion_rate', 'Currency conversion rates', ['currency'])

@app.get("/date/{date}")
def get_all_rates(date: int):
    try:
        rates = get_rates_for_date(date)
        # Update Prometheus gauge
        for currency, rate in rates.items():
            conversion_gauge.labels(currency=currency).set(rate)
        return [{"currency": k, "rate": v} for k, v in rates.items()]
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/")
def convert(payload: dict):
    try:
        date = int(payload["date"])
        from_curr = payload["from_currency"]
        to_curr = payload["to_currency"]
        amount = float(payload["amount"])
        result, rate = convert_currency(date, from_curr, to_curr, amount)
        return {
            "converted_amount": result,
            "exchange_rate": rate
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.get("/metrics")
def metrics():
    return Response(generate_latest(), media_type="text/plain")
