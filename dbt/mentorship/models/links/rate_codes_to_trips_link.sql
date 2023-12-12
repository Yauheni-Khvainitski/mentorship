{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
link_hashkey: 'hk_rate_code_to_trip'
foreign_hashkeys:
    - 'hk_rate_code'
    - 'hk_trip'
source_models:
    - name: stg_ny_taxi_yellow
      rsrc_static: '!yellow_ny_taxi_data'
    - name: stg_ny_taxi_green
      rsrc_static: '!green_ny_taxi_data'
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{%- set link_hashkey = metadata_dict['link_hashkey'] -%}
{%- set foreign_hashkeys = metadata_dict['foreign_hashkeys'] -%}
{%- set source_models = metadata_dict['source_models'] -%}


{{
    datavault4dbt.link(
        link_hashkey=link_hashkey,
        foreign_hashkeys=foreign_hashkeys,
        source_models=source_models
    )
}}
