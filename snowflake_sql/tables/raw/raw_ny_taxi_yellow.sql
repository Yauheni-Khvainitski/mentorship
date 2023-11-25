CREATE OR REPLACE TABLE mentorship_db.raw.ny_taxi_yellow (
    do_location_id INT,
    pu_location_id INT,
    ratecode_id FLOAT,
    vendor_id INT,
    airport_fee FLOAT,
    congestion_surcharge FLOAT,
    extra FLOAT,
    fare_amount FLOAT,
    improvement_surcharge FLOAT,
    mta_tax FLOAT,
    passenger_count FLOAT,
    payment_type INT,
    store_and_fwd_flag VARCHAR(32),
    tip_amount FLOAT,
    tolls_amount FLOAT,
    total_amount FLOAT,
    tpep_dropoff_datetime BIGINT,
    tpep_pickup_datetime BIGINT,
    trip_distance FLOAT,
    file_name VARCHAR(256),
    file_row_number BIGINT,
    load_dttm TIMESTAMP_NTZ
)
CLUSTER BY (load_dttm);

select * from mentorship_db.raw.ny_taxi_yellow limit 10;
