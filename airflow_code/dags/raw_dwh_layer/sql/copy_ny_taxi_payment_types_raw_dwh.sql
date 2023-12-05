COPY INTO mentorship_db.raw.ny_taxi_payment_types
FROM (
    SELECT
        $1::INT AS payment_type_id,
        $2::STRING AS payment_type_description,
        METADATA$FILENAME,
        METADATA$FILE_ROW_NUMBER,
        SYSDATE()
    FROM
        @mentorship_db.external_stages.stg_ny_taxi_payment_types
);
