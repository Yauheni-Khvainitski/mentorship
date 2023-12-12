{{ config(materialized='view') }}

{%- set yaml_metadata -%}
sat_v0: 'payment_types_yellow_sat_v0'
hashkey: 'hk_payment_type'
hashdiff: 'hd_payment_type'
ledts_alias: 'load_end_date'
add_is_current_flag: true
{%- endset -%}

{%- set metadata_dict = fromyaml(yaml_metadata) -%}

{{
    datavault4dbt.sat_v1(
        sat_v0=metadata_dict['sat_v0'],
        hashkey=metadata_dict['hashkey'],
        hashdiff=metadata_dict['hashdiff'],
        ledts_alias=metadata_dict['ledts_alias'],
        add_is_current_flag=metadata_dict['add_is_current_flag']
    )
}}
