CREATE OR REPLACE STAGE mentorship_db.external_stages.stg_ny_taxi_green_trip_types
    URL='s3://datalake-mentorship-bucket/raw/ny_taxi/green_ny_taxi_trip_types/'
    STORAGE_INTEGRATION = mentorship_datalake
    FILE_FORMAT = mentorship_db.external_stages.ff_ny_taxi_csv;
