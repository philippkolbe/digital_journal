FROM python:3.9

WORKDIR /app

COPY requirements.txt .
COPY .env .

RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY . .

EXPOSE 6000

CMD ["python", "app.py"]