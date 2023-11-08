# Local Docker Image Test

This project contains the setup for testing a local Docker image with a Postgres database.

## Create network for containers

```bash
docker network create postgres_network
```

## Postgres Database Creation Commands

### Run Postgres Container

To start the Postgres container, use the following command:

```bash
docker run -it \
    --env-file postgres.env \
    -v $(pwd)/pg_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    --network postgres_network \
    --name postgres_database \
    postgres:13
```

## Connect to Postgres Database

### Connect to Postgres Database using pgcli

To connect to the Postgres database, use the following command:

```bash
./run_pgcli.sh
```

### Connect to Postgres Database using pgAdmin

To start the pgAdmin container, use the following command:

```bash
docker run -it \
    --env-file pgadmin.env \
    -p 8080:80 \
    --network postgres_network \
    --name pgadmin \
    dpage/pgadmin4
```


## Ingesting data locally

### Ingest data using ingest_data.py

To ingest data into the Postgres database, use the following command:

```bash
docker run -it \
  --name ingest \
  --network postgres_network \
  taxi_ingest:v001 \
  --table-name yellow_taxi_data \
  --url https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet
```
