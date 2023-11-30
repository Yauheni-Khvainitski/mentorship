{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
    raw: 'ny_taxi_zones'
ldts: 'load_dttm'
rsrc: '!ny_taxi_zones_data'
hashed_columns:
    hk_location_id:
        - location_id
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{%- set source_model = metadata_dict['source_model'] -%}
{%- set ldts = metadata_dict['ldts'] -%}
{%- set rsrc = metadata_dict['rsrc'] -%}
{%- set hashed_columns = metadata_dict['hashed_columns'] -%}

{{ datavault4dbt.stage(
    source_model=source_model,
    ldts=ldts,
    rsrc=rsrc,
    hashed_columns=hashed_columns
    ) }}
