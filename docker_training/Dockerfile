FROM python:3.9

RUN apt-get update && apt-get install -y curl && \
    pip install pandas==2.1.2 \
    pyarrow==14.0.0 \
    sqlalchemy==2.0.23 \
    psycopg2==2.9.9 \
    python-dotenv==1.0.0

WORKDIR /app

COPY ingest_data.py postgres.env /app/

ENTRYPOINT [ "python", "ingest_data.py" ]
