COPY INTO mentorship_db.raw.ny_taxi_vendors
FROM (
    SELECT
        $1::INT AS vendor_id,
        $2::STRING AS vendor_name,
        METADATA$FILENAME,
        METADATA$FILE_ROW_NUMBER,
        SYSDATE()
    FROM
        @mentorship_db.external_stages.stg_ny_taxi_vendors
);
