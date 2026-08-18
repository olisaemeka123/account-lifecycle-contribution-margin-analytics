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
    s.tier as current_tier
from {{ ref('stg_daily_balances') }} as d

left join {{ ref('int_account_month_status') }} as s
    on d.account_id = s.account_id
    and date_trunc(d.balance_date, month) = s.month

{% if is_incremental() %}
where d.balance_date > (select max(balance_date) from {{ this }})
{% endif %}