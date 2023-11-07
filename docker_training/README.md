# Local Docker Image Test

This project contains the setup for testing a local Docker image with a Postgres database.

## Postgres Database Creation Commands

### Run Postgres Container

To start the Postgres container, use the following command:

```bash
docker run -it \
    --env-file postgres.env \
    -v $(pwd)/pg_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres:13
```

### Connect to Postgres Database

To connect to the Postgres database, use the following command:

```bash
./run_pgcli.sh
```
