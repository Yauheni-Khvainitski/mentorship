from datetime import datetime

from airflow import DAG
from airflow.operators.empty import EmptyOperator
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator

from global_constants import NY_TAXI_TYPES

default_args = {
    "depends_on_past": True,
    "retries": 0,
}


def get_load_to_raw_dwh_operator(taxi_type_arg):
    sql_mapping = {
        "yellow": "sql/copy_ny_taxi_yellow_raw_dwh.sql",
        "green": "sql/copy_ny_taxi_green_raw_dwh.sql",
        "fhv": "sql/copy_ny_taxi_fhv_raw_dwh.sql",
    }

    if taxi_type_arg in sql_mapping:
        sql_file = sql_mapping[taxi_type_arg]
        return SnowflakeOperator(
            task_id=f"load_ny_taxi_{taxi_type_arg}_to_raw_dwh",
            snowflake_conn_id="snowflake",
            sql=sql_file,
        )
    else:
        return EmptyOperator(
            task_id=f"dummy_load_ny_taxi_{taxi_type_arg}_to_raw_dwh",
        )


with DAG(
    dag_id="ny_taxi_to_raw_dwh",
    start_date=datetime(2023, 11, 1),
    schedule_interval=None,
) as dag:

    for taxi_type in NY_TAXI_TYPES:
        load_to_raw_dwh_operator = get_load_to_raw_dwh_operator(taxi_type)
