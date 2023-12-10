{{
    config(
        materialized='incremental',
        on_schema_change='append_new_columns'
    )
}}

{%- set yaml_metadata -%}
parent_hashkey: 'hk_trip'
src_hashdiff: 'hd_trip'
src_payload:
    - ratecode_id
    - vendor_id
    - airport_fee
    - congestion_surcharge
    - extra
    - fare_amount
    - improvement_surcharge
    - mta_tax
    - passenger_count
    - tip_amount
    - tolls_amount
source_model: 'stg_ny_taxi_yellow'
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{
    datavault4dbt.sat_v0(
        parent_hashkey=metadata_dict['parent_hashkey'],
        src_hashdiff=metadata_dict['src_hashdiff'],
        source_model=metadata_dict['source_model'],
        src_payload=metadata_dict['src_payload']
    )
}}