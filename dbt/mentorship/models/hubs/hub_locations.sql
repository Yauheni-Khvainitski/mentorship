{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
hashkey: 'hk_location_id'
business_keys:
    - location_id
source_models:
    - name: stg_ny_taxi_zones
      rsrc_static: 'ny_taxi_zones_data'
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{%- set hashkey = metadata_dict['hashkey'] -%}
{%- set business_keys = metadata_dict['business_keys'] -%}
{%- set source_models = metadata_dict['source_models'] -%}

{{ datavault4dbt.hub(hashkey=hashkey,
                    business_keys=business_keys,
                    source_models=source_models) }}
