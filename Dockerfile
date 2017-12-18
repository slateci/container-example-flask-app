FROM ubuntu:latest

ENV FLASK_APP=/app/app.py

WORKDIR /app

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev build-essential

COPY app/ /app

RUN pip install -r requirements.txt

CMD ["flask", "run", "-h", "0.0.0.0"]
