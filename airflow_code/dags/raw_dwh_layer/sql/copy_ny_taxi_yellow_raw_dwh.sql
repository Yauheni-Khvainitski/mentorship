COPY INTO mentorship_db.raw.ny_taxi_yellow
FROM (
    SELECT
        $1:"DOLocationID"::INT,
        $1:"PULocationID"::INT,
        $1:"RatecodeID"::FLOAT,
        $1:"VendorID"::INT,
        $1:"airport_fee"::FLOAT,
        $1:"congestion_surcharge"::FLOAT,
        $1:"extra"::FLOAT,
        $1:"fare_amount"::FLOAT,
        $1:"improvement_surcharge"::FLOAT,
        $1:"mta_tax"::FLOAT,
        $1:"passenger_count"::FLOAT,
        $1:"payment_type"::INT,
        $1:"store_and_fwd_flag"::VARCHAR(32),
        $1:"tip_amount"::FLOAT,
        $1:"tolls_amount"::FLOAT,
        $1:"total_amount"::FLOAT,
        $1:"tpep_dropoff_datetime"::BIGINT,
        $1:"tpep_pickup_datetime"::BIGINT,
        $1:"trip_distance"::FLOAT,
        METADATA$FILENAME,
        METADATA$FILE_ROW_NUMBER,
        SYSDATE()
    FROM
        @mentorship_db.external_stages.stg_ny_taxi_yellow
);
