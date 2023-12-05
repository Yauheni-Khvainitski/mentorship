COPY INTO mentorship_db.raw.ny_taxi_rate_codes
FROM (
    SELECT
        $1::INT AS rate_code_id,
        $2::STRING AS rate_code_description,
        METADATA$FILENAME,
        METADATA$FILE_ROW_NUMBER,
        SYSDATE()
    FROM
        @mentorship_db.external_stages.stg_ny_taxi_rate_codes
);
