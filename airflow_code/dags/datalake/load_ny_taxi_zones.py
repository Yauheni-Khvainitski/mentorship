from datetime import datetime

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.amazon.aws.transfers.local_to_s3 import LocalFilesystemToS3Operator

from datalake.constants import (
    DATALAKE_BUKET,
    NY_TAXI_LOCAL_FILESYSTEM_PREFIX,
    TAXI_ZONES_URL,
    TAXI_ZONES_FILE_NAME,
)

default_args = {
    "depends_on_past": False,
    "retries": 0,
}

with DAG(
        dag_id="ny_taxi_zones_to_raw_datalake",
        start_date=datetime(2023, 11, 1),
        schedule_interval=None,
        catchup=False,
        max_active_runs=1,
) as dag:
    # TODO: move to ECS
    download_ny_taxi_zones_data = BashOperator(
        task_id=f"download_taxi_zones_data",
        bash_command=f"curl -o "
                     f"{NY_TAXI_LOCAL_FILESYSTEM_PREFIX}{TAXI_ZONES_FILE_NAME} "
                     f"{TAXI_ZONES_URL}",
    )

    # TODO: skip if file is empty
    # Link for future will also generate an empty file
    load_to_datalake = LocalFilesystemToS3Operator(
        task_id=f"taxi_zones_data_to_raw_datalake",
        filename=f"{NY_TAXI_LOCAL_FILESYSTEM_PREFIX}{TAXI_ZONES_FILE_NAME}",
        dest_bucket=DATALAKE_BUKET,
        dest_key=f"raw/ny_taxi/taxi_zones_lookup/"
                 f"{TAXI_ZONES_FILE_NAME}",
        replace=True,
        aws_conn_id="aws",
        encrypt=True,
    )

    # TODO: remove after moving download task to ECS
    remove_local_ny_taxi_zones_data = BashOperator(
        task_id=f"remove_ny_taxi_zones_data",
        bash_command=f"rm -f {NY_TAXI_LOCAL_FILESYSTEM_PREFIX}{TAXI_ZONES_FILE_NAME}",
    )

    trigger_raw_dwh_load = TriggerDagRunOperator(
        task_id="trigger_raw_dwh_load",
        trigger_dag_id="ny_taxi_zones_to_raw_dwh",
        reset_dag_run=True,
        wait_for_completion=False,
    )

    (
        download_ny_taxi_zones_data >>
        load_to_datalake >>
        remove_local_ny_taxi_zones_data >>
        trigger_raw_dwh_load
    )
