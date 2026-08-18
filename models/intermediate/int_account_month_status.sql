
with spine as (

    select account_id, month
    from {{ ref('int_account_month_spine') }}

),

history as (

    select account_id, status, tier, effective_date
    from {{ ref('stg_account_status_history') }}

),

joined as (

    -- include every history row that was effective on or before this month. 
    -- This can create multiple historical rows per account,month if the status/tier changed more than once
    --effective_date is truncated to the start of its month
    -- before comparing, since spine.month is always the 1st of the
    -- month but effective_date can be any day (e.g. 2024-05-19)
    -- without truncating, a status that started mid month would
    -- incorrectly fail to match that same month's row
    select
        spine.account_id,
        spine.month,
        history.status,
        history.tier,
        history.effective_date
    from spine
    left join history
        on spine.account_id = history.account_id
        and date_trunc(history.effective_date, month) <= spine.month

)

-- include only the Most recent matching history row per account-month
select
    account_id,
    month,
    status,
    tier
from joined

qualify row_number() over (
    partition by account_id, month
    order by effective_date desc
) = 1