COPY INTO mentorship_db.raw.ny_taxi_zones
FROM (
    SELECT
        $1::INT AS location_id,
        $2::STRING AS borough,
        $3::STRING AS zone,
        $4::STRING AS service_zone,
        METADATA$FILENAME,
        METADATA$FILE_ROW_NUMBER,
        SYSDATE()
    FROM
        @mentorship_db.external_stages.stg_ny_taxi_zones
);
