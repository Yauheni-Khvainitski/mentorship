{{
    config(
        materialized='incremental',
        on_schema_change='append_new_columns'
    )
}}

{%- set yaml_metadata -%}
parent_hashkey: 'hk_location_id'
src_hashdiff: 'hd_location'
src_payload:
    - borough
    - zone
    - service_zone
source_model: 'stg_ny_taxi_zones'
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