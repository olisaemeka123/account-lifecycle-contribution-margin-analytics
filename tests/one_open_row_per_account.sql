select account_id, count(*) as open_row_count
from {{ ref('snap_accounts') }}
where dbt_valid_to is null
group by account_id
having count(*) != 1