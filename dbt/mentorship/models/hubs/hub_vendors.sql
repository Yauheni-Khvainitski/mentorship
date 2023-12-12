{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
hashkey: 'hk_vendor'
business_keys:
    - vendor_id
source_models:
    - name: stg_ny_taxi_yellow
      hk_column: 'hk_vendor'
      bk_columns:
          - vendor_id
      rsrc_static: '!yellow_ny_taxi_data'
    - name: stg_ny_taxi_green
      hk_column: 'hk_vendor'
      bk_columns:
          - vendor_id
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