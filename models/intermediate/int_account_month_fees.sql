with fee_summary as (
    select
        account_id,
        date_trunc(fee_date, month) as month,
        sum(fee_amount) as fee_revenue
    from {{ ref('stg_fee_events') }}
    group by 1, 2
)

select
    g.account_id,
    g.month,
    coalesce(f.fee_revenue, 0) as fee_revenue
from {{ref('int_account_month_spine')}} as g
left join fee_summary as f
    on g.account_id = f.account_id
    and g.month = f.month