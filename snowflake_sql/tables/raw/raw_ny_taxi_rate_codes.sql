CREATE OR REPLACE TABLE mentorship_db.raw.ny_taxi_rate_codes (
    rate_code_id INT,
    rate_code_description VARCHAR(256),
    file_name VARCHAR(256),
    file_row_number BIGINT,
    load_dttm TIMESTAMP_NTZ
)
CLUSTER BY (load_dttm);
