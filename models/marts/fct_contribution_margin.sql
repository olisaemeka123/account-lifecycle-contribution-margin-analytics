with contribution_margin_logic as (
        select 
            f.account_id,
            f.month,
            f.fee_revenue,
            a.current_status,
            a.current_tier,  
            b.monthly_cost_per_account as monthly_cost,
            {{calculate_contribution_margin('f.fee_revenue', 'b.monthly_cost_per_account')}} as contribution_margin

        from {{ref ('int_account_month_fees')}} as f 

        left join {{ ref ('stg_accounts')}} as a
            on f.account_id = a.account_id

        left join {{ref('stg_cost_allocation')}} as b
        on a.current_tier = b.tier)

        select * from contribution_margin_logic