COPY INTO mentorship_db.raw.ny_taxi_fhv
FROM (
    SELECT
        $1:"Affiliated_base_number"::VARCHAR(256),
        $1:"dispatching_base_num"::VARCHAR(256),
        $1:"dropOff_datetime"::BIGINT,
        $1:"pickup_datetime"::BIGINT,
        METADATA$FILENAME,
        METADATA$FILE_ROW_NUMBER,
        SYSDATE()
    FROM
        @mentorship_db.external_stages.stg_ny_taxi_fhv
);
