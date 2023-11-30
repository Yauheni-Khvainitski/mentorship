from datetime import datetime

from airflow import DAG
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator

default_args = {
    "depends_on_past": True,
    "retries": 0,
}


with DAG(
    dag_id="ny_taxi_zones_to_raw_dwh",
    start_date=datetime(2023, 11, 1),
    schedule_interval=None,
) as dag:
    load_ny_taxi_zones_to_dwh = SnowflakeOperator(
        task_id="load_ny_taxi_zones_to_raw_dwh",
        snowflake_conn_id="snowflake",
        sql="sql/copy_ny_taxi_zones_raw_dwh.sql",
    )
