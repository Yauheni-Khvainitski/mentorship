CREATE OR REPLACE FILE FORMAT mentorship_db.external_stages.ff_ny_taxi_csv
    TYPE = 'CSV'
    COMPRESSION = NONE
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"';
