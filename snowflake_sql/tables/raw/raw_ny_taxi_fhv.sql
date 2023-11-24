CREATE OR REPLACE TABLE mentorship_db.raw.ny_taxi_fhv (
    affiliated_base_number VARCHAR(256),
    dispatching_base_num VARCHAR(256),
    dropoff_datetime BIGINT,
    pickup_datetime BIGINT,
    file_name VARCHAR(256),
    file_row_number BIGINT,
    load_dttm TIMESTAMP_NTZ
)
CLUSTER BY (load_dttm);
