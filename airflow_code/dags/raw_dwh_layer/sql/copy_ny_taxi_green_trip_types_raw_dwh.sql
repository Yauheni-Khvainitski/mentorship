COPY INTO mentorship_db.raw.ny_taxi_green_trip_types
FROM (
    SELECT
        $1::INT AS trip_type_id,
        $2::STRING AS trip_type_description,
        METADATA$FILENAME,
        METADATA$FILE_ROW_NUMBER,
        SYSDATE()
    FROM
        @mentorship_db.external_stages.stg_ny_taxi_green_trip_types
);
