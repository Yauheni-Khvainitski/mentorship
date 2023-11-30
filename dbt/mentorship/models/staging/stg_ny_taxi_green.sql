{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
    raw: 'ny_taxi_green'
ldts: 'load_dttm'
rsrc: '!green_ny_taxi_data'
hashed_columns:
    hk_vendor:
        - vendor_id
    hk_pickup_location:
        - pu_location_id
    hk_dropoff_location:
        - do_location_id
    hk_rate_code:
        - ratecode_id
    hk_payment_type:
        - payment_type
derived_columns:
    lpep_pickup_datetime_epoch:
        value: 'lpep_pickup_datetime'
        datatype: 'BIGINT'
    lpep_pickup_datetime_derived_ts:
        value: 'TO_TIMESTAMP_NTZ(lpep_pickup_datetime / 1000000)'
        datatype: 'TIMESTAMP_NTZ'
    lpep_dropoff_datetime_epoch:
        value: 'lpep_dropoff_datetime'
        datatype: 'BIGINT'
    lpep_dropoff_datetime_derived_ts:
        value: 'TO_TIMESTAMP_NTZ(lpep_dropoff_datetime / 1000000)'
        datatype: 'TIMESTAMP_NTZ'
    taxi_type:
        value: '!green'
        datatype: 'STRING'
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{%- set source_model = metadata_dict['source_model'] -%}
{%- set ldts = metadata_dict['ldts'] -%}
{%- set rsrc = metadata_dict['rsrc'] -%}
{%- set hashed_columns = metadata_dict['hashed_columns'] -%}
{%- set derived_columns = metadata_dict['derived_columns'] -%}

{{ datavault4dbt.stage(
    source_model=source_model,
    ldts=ldts,
    rsrc=rsrc,
    hashed_columns=hashed_columns,
    derived_columns=derived_columns
    ) }}