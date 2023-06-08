FROM python:3.9

WORKDIR /app

COPY requirements.txt .
COPY .env .

RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY . .

EXPOSE 5001

CMD ["flask", "run", "--host", "0.0.0.0", "--port", "5001"]