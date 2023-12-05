CREATE OR REPLACE TABLE mentorship_db.raw.ny_taxi_green_trip_types (
    trip_type_id INT,
    trip_type_description VARCHAR(256),
    file_name VARCHAR(256),
    file_row_number BIGINT,
    load_dttm TIMESTAMP_NTZ
)
CLUSTER BY (load_dttm);
