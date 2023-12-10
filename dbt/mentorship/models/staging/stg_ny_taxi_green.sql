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
    hk_trip:
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
    hd_trip:
        is_hashdiff: true
        use_rtrim: true
        columns:
            - ratecode_id
            - vendor_id
            - congestion_surcharge
            - extra
            - fare_amount
            - improvement_surcharge
            - mta_tax
            - passenger_count
            - tip_amount
            - tolls_amount
            - trip_type
    hk_trip_to_pickup_location:
        - hk_pickup_location
        - hk_trip
    hk_trip_to_dropoff_location:
        - hk_dropoff_location
        - hk_trip
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
prejoined_columns:
    vendor_name:
        src_name: 'raw'
        src_table: 'ny_taxi_vendors'
        bk: 'vendor_name'
        this_column_name: 'vendor_id'
        ref_column_name: 'vendor_id'
    rate_code_description:
        src_name: 'raw'
        src_table: 'ny_taxi_rate_codes'
        bk: 'rate_code_description'
        this_column_name: 'ratecode_id'
        ref_column_name: 'rate_code_id'
    payment_type_description:
        src_name: 'raw'
        src_table: 'ny_taxi_payment_types'
        bk: 'payment_type_description'
        this_column_name: 'payment_type'
        ref_column_name: 'payment_type_id'
    trip_type_description:
        src_name: 'raw'
        src_table: 'ny_taxi_green_trip_types'
        bk: 'trip_type_description'
        this_column_name: 'trip_type'
        ref_column_name: 'trip_type_id'

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
