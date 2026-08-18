
select
    account_id,
    month,
    current_status,
    monthly_cost
from {{ ref('fct_contribution_margin') }}
where current_status = 'churned'
  and monthly_cost != 0