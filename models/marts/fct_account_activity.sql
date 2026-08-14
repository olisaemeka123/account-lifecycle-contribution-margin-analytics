select
    account_id,
    month as activity_month,
    transaction_count,
    total_transaction_volume
from {{ ref('int_account_month_activity') }}