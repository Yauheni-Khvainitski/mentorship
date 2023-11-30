CREATE OR REPLACE STAGE mentorship_db.external_stages.stg_ny_taxi_zones
    URL='s3://datalake-mentorship-bucket/raw/ny_taxi/taxi_zones_lookup/'
    STORAGE_INTEGRATION = mentorship_datalake
    FILE_FORMAT = mentorship_db.external_stages.ff_ny_taxi_zones_csv;
