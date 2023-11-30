CREATE OR REPLACE TABLE mentorship_db.raw.ny_taxi_zones (
    location_id INT,
    borough VARCHAR(256),
    zone VARCHAR(256),
    service_zone VARCHAR(256),
    file_name VARCHAR(256),
    file_row_number BIGINT,
    load_dttm TIMESTAMP_NTZ
)
CLUSTER BY (load_dttm);
