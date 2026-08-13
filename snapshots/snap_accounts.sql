{% snapshot snap_accounts %}

{{
    config(
      target_schema='snapshots',
      unique_key='account_id',
      strategy='check',
      check_cols=['current_status', 'current_tier'],
    )
}}

select * from {{ ref('stg_accounts') }}

{% endsnapshot %}