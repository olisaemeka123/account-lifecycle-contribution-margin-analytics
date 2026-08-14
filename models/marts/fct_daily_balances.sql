{{
    config(
        materialized='incremental',
        unique_key=['account_id', 'balance_date'],
        incremental_strategy='merge'
    )
}}

select 
    d.account_id,
    d.balance_date,
    d.balance_amount,
    a.current_tier
from {{ref ('stg_daily_balances')}} as d
left join {{ref ('stg_accounts')}} as a
on d.account_id = a.account_id

{% if is_incremental () %}
where balance_date > (select max(balance_date) from {{ this }})
{% endif %}