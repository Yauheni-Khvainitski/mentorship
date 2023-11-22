CREATE ROLE etl
    COMMENT = 'Role for orchestrator and other services that need to load the data';

GRANT ROLE etl
   TO ROLE sysadmin;

GRANT USAGE
    ON WAREHOUSE MENTORSHIP_DWH
    TO ROLE etl;

GRANT USAGE
    ON DATABASE mentorship_db
    TO ROLE etl;

GRANT CREATE SCHEMA
    ON DATABASE mentorship_db
    TO ROLE etl;

GRANT USAGE ON INTEGRATION mentorship_datalake
    TO ROLE etl;
