{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
hashkey: 'hk_trip'
business_keys:
    - do_location_id
    - pu_location_id
    - pickup_datetime_epoch
    - dropoff_datetime_epoch
    - pickup_datetime_ts
    - dropoff_datetime_ts
    - payment_type
    - trip_distance
    - store_and_fwd_flag
    - total_amount
    - taxi_type
source_models:
    - name: stg_ny_taxi_yellow
      hk_column: 'hk_trip'
      bk_columns:
          - do_location_id
          - pu_location_id
          - tpep_pickup_datetime
          - tpep_dropoff_datetime
          - tpep_pickup_datetime_derived_ts
          - tpep_dropoff_datetime_derived_ts
          - payment_type
          - trip_distance
          - store_and_fwd_flag
          - total_amount
          - taxi_type
      rsrc_static: '!yellow_ny_taxi_data'
    - name: stg_ny_taxi_green
      hk_column: 'hk_trip'
      bk_columns:
          - do_location_id
          - pu_location_id
          - lpep_pickup_datetime
          - lpep_dropoff_datetime
          - lpep_pickup_datetime_derived_ts
          - lpep_dropoff_datetime_derived_ts
          - payment_type
          - trip_distance
          - store_and_fwd_flag
          - total_amount
          - taxi_type
      rsrc_static: '!green_ny_taxi_data'
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{%- set hashkey = metadata_dict['hashkey'] -%}
{%- set business_keys = metadata_dict['business_keys'] -%}
{%- set source_models = metadata_dict['source_models'] -%}

{{
    datavault4dbt.hub(
        hashkey=hashkey,
        business_keys=business_keys,
        source_models=source_models
    )
}}