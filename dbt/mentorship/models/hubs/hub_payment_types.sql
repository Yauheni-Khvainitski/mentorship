{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
hashkey: 'hk_payment_type'
business_keys:
    - payment_type
source_models:
    - name: stg_ny_taxi_yellow
      hk_column: 'hk_payment_type'
      bk_columns:
          - payment_type
      rsrc_static: '!yellow_ny_taxi_data'
    - name: stg_ny_taxi_green
      hk_column: 'hk_payment_type'
      bk_columns:
          - payment_type
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
