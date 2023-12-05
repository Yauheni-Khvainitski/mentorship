CREATE OR REPLACE TABLE mentorship_db.raw.ny_taxi_vendors (
    vendor_id INT,
    vendor_name VARCHAR(256),
    file_name VARCHAR(256),
    file_row_number BIGINT,
    load_dttm TIMESTAMP_NTZ
)
CLUSTER BY (load_dttm);
