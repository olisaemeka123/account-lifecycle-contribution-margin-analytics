with activity_summary as (
    select
        account_id,
        date_trunc(transaction_date, month) as month,
        count(*) as transaction_count,
        sum(amount) as total_transaction_volume
    from {{ ref('stg_transactions') }}
    group by 1, 2
)

select
    g.account_id,
    g.month,
    coalesce(a.transaction_count, 0) as transaction_count,
    coalesce(a.total_transaction_volume, 0) as total_transaction_volume
from {{ ref('int_account_month_spine') }} as g
left join activity_summary as a
    on g.account_id = a.account_id
    and g.month = a.month