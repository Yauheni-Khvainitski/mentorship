from datetime import datetime

from airflow import DAG
from airflow.operators.bash import BashOperator

default_args = {
    "depends_on_past": True,
    "retries": 0,
}

with DAG(
    dag_id="yellow_taxi_to_datalake",
    start_date=datetime(2022, 1, 1),
    schedule_interval="@monthly",
    catchup=True,
    max_active_runs=3,
) as dag:

    TAXI_TYPE = "yellow"
    FILE_FORMAT = "parquet"
    URL_PREFIX = "https://d37ci6vzurychx.cloudfront.net/trip-data/"
    LOCAL_PATH = "/tmp/"

    download_ny_taxi_data = BashOperator(
        task_id=f"download_{TAXI_TYPE}_ny_taxi_data",
        bash_command=f"curl -o "
                     f"{LOCAL_PATH}{TAXI_TYPE}_tripdata_"
                     f"{{{{ macros.ds_format(ds, '%Y-%m-%d', '%Y-%m') }}}}.{FILE_FORMAT} "
                     f"{URL_PREFIX}{TAXI_TYPE}_tripdata_"
                     f"{{{{ macros.ds_format(ds, '%Y-%m-%d', '%Y-%m') }}}}.{FILE_FORMAT}",
    )
