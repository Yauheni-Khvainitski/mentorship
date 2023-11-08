import os
import argparse
from time import time

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine


def main(params):

    load_dotenv("postgres.env")

    user = os.environ.get("POSTGRES_USER")
    password = os.environ.get("POSTGRES_PASSWORD")
    host = os.environ.get("POSTGRES_HOST")
    port = str(os.environ.get("POSTGRES_PORT"))
    db = os.environ.get("POSTGRES_DB")
    table_name = params.table_name
    url = params.url

    file_name = "output.parquet"

    os.system(f"curl {url} -o {file_name}")
    print("file downloaded")

    df = pd.read_parquet(file_name)
    print("df read")

    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

    engine = create_engine(f"postgresql://{user}:{password}@{host}:{port}/{db}")
    engine.connect()
    print("connected to db")

    df.head(n=0).to_sql(name=table_name, con=engine, if_exists="replace")
    print("table created")

    t_start = time()
    df.to_sql(name=table_name, con=engine, if_exists="append")
    t_end = time()
    print("Data inserted, took %.3f second" % (t_end - t_start))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        prog='NYTaxiDataIngestion',
        description='Ingest NY Taxi data into PostgreSQL',
    )

    parser.add_argument('--table-name', help='table name to write to')
    parser.add_argument('--url', help='url of the data')

    args = parser.parse_args()

    main(args)
