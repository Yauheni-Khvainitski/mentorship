{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
    raw: 'ny_taxi_yellow'
ldts: 'load_dttm'
rsrc: '!yellow_ny_taxi_data'
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
    tpep_pickup_datetime_epoch:
        value: 'tpep_pickup_datetime'
        datatype: 'BIGINT'
    tpep_pickup_datetime_derived_ts:
        value: 'TO_TIMESTAMP_NTZ(tpep_pickup_datetime / 1000000)'
        datatype: 'TIMESTAMP_NTZ'
    tpep_dropoff_datetime_epoch:
        value: 'tpep_dropoff_datetime'
        datatype: 'BIGINT'
    tpep_dropoff_datetime_derived_ts:
        value: 'TO_TIMESTAMP_NTZ(tpep_dropoff_datetime / 1000000)'
        datatype: 'TIMESTAMP_NTZ'
    taxi_type:
        value: '!yellow'
        datatype: 'STRING'
prejoined_columns:
    vendor_name:
        src_name: 'raw'
        src_table: 'ny_taxi_vendors'
        bk: 'vendor_name'
        this_column_name: 'vendor_id'
        ref_column_name: 'vendor_id'

{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{%- set source_model = metadata_dict['source_model'] -%}
{%- set ldts = metadata_dict['ldts'] -%}
{%- set rsrc = metadata_dict['rsrc'] -%}
{%- set hashed_columns = metadata_dict['hashed_columns'] -%}
{%- set derived_columns = metadata_dict['derived_columns'] -%}
{%- set prejoined_columns = metadata_dict['prejoined_columns'] -%}

{{ datavault4dbt.stage(
    source_model=source_model,
    ldts=ldts,
    rsrc=rsrc,
    hashed_columns=hashed_columns,
    derived_columns=derived_columns,
    prejoined_columns=prejoined_columns
    ) }}
