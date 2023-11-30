from datetime import datetime

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.amazon.aws.transfers.local_to_s3 import LocalFilesystemToS3Operator
from airflow.utils.task_group import TaskGroup

from datalake.constants import (
    DATALAKE_BUKET,
    NY_TAXI_FILE_FORMAT,
    NY_TAXI_URL_PREFIX,
    NY_TAXI_LOCAL_FILESYSTEM_PREFIX,
)

from global_constants import NY_TAXI_TYPES

default_args = {
    "depends_on_past": True,
    "retries": 0,
}

with DAG(
    dag_id="ny_taxi_to_raw_datalake",
    start_date=datetime(2022, 1, 1),
    schedule_interval="@monthly",
    catchup=True,
    max_active_runs=3,
) as dag:

    with TaskGroup(group_id="load_datalake") as load_datalake_tg:
        dummy_start = EmptyOperator(
            task_id="dummy_start_load"
        )

        for taxi_type in NY_TAXI_TYPES:
            # TODO: move to ECS
            download_ny_taxi_data = BashOperator(
                task_id=f"download_{taxi_type}_ny_taxi_data",
                bash_command=f"curl -o "
                             f"{NY_TAXI_LOCAL_FILESYSTEM_PREFIX}{taxi_type}_tripdata_"
                             f"{{{{ macros.ds_format(ds, '%Y-%m-%d', '%Y-%m') }}}}"
                             f".{NY_TAXI_FILE_FORMAT} {NY_TAXI_URL_PREFIX}{taxi_type}_tripdata_"
                             f"{{{{ macros.ds_format(ds, '%Y-%m-%d', '%Y-%m') }}}}"
                             f".{NY_TAXI_FILE_FORMAT}",
            )

            # TODO: skip if file is empty
            # Link for future will also generate an empty file
            load_to_datalake = LocalFilesystemToS3Operator(
                task_id=f"{taxi_type}_taxi_data_to_raw_datalake",
                filename=f"{NY_TAXI_LOCAL_FILESYSTEM_PREFIX}{taxi_type}_tripdata_"
                         f"{{{{ macros.ds_format(ds, '%Y-%m-%d', '%Y-%m') }}}}."
                         f"{NY_TAXI_FILE_FORMAT}",
                dest_bucket=DATALAKE_BUKET,
                dest_key=f"raw/ny_taxi/{taxi_type}/"
                         f"{{{{ macros.ds_format(ds, '%Y-%m-%d', '%Y-%m') }}}}/"
                         f"{taxi_type}_{{{{ macros.ds_format(ds, '%Y-%m-%d', '%Y-%m') }}}}"
                         f"_monthly_data.{NY_TAXI_FILE_FORMAT}",
                replace=True,
                aws_conn_id="aws",
                encrypt=True,
            )

            # TODO: remove after moving download task to ECS
            remove_local_ny_taxi_data = BashOperator(
                task_id=f"remove_{taxi_type}_ny_taxi_data",
                bash_command=f"rm -f "
                             f"{NY_TAXI_LOCAL_FILESYSTEM_PREFIX}{taxi_type}_tripdata_"
                             f"{{{{ macros.ds_format(ds, '%Y-%m-%d', '%Y-%m') }}}}"
                             f".{NY_TAXI_FILE_FORMAT}",
            )

            dummy_start >> download_ny_taxi_data >> load_to_datalake >> remove_local_ny_taxi_data

    trigger_raw_dwh_load = TriggerDagRunOperator(
        task_id="trigger_raw_dwh_load",
        trigger_dag_id="ny_taxi_to_raw_dwh",
        reset_dag_run=True,
        wait_for_completion=False,
    )

    load_datalake_tg >> trigger_raw_dwh_load
