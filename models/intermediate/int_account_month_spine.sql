/* fee_events only has rows for account_id & months where a fee occured. 
if i join stg-accounts to fee aggregated data, accounts with 0 fees in a given month
would be missing that month entirely and this breaks the month over month trend
chart. i therefore used a cross join to generate every account * every month
combination first then left joined fee activity unto that complete grid
so every account has exactly one row per month with 0 fee revenue where
none occured. */ 

--end date in dbt_utils.date_spine is exclusive so 2025-04-01 correctly produces 15 months through to 2025-03-01 matching the raw data

with months as (
    {{ dbt_utils.date_spine(
        datepart="month",
        start_date="cast('2024-01-01' as date)",
        end_date="cast('2025-04-01' as date)" 
    ) }}
)


    select
        a.account_id,
        cast(m.date_month as date) as month
    from {{ ref('stg_accounts') }} as a
    cross join months as m
