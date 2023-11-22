CREATE OR REPLACE FILE FORMAT mentorship_db.external_stages.ff_ny_taxi_parquet
    TYPE = 'parquet'
    BINARY_AS_TEXT = FALSE
    TRIM_SPACE = FALSE
    USE_LOGICAL_TYPE = FALSE
    REPLACE_INVALID_CHARACTERS = TRUE;
