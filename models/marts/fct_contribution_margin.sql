with contribution_margin_logic as (

    select
        f.account_id,
        f.month,
        f.fee_revenue,
        s.status as current_status,
        s.tier as current_tier,
        -- churned accounts no longer incur a maintenance cost;
        -- dormant accounts still do, since they remain open and assumed operational
        case
            when s.status = 'churned' then 0
            else b.monthly_cost_per_account
        end as monthly_cost

    from {{ ref('int_account_month_fees') }} as f

    left join {{ ref('int_account_month_status') }} as s
        on f.account_id = s.account_id
        and f.month = s.month

    left join {{ ref('stg_cost_allocation') }} as b
        on s.tier = b.tier

),

final as (

    select
        *,
        {{ calculate_contribution_margin('fee_revenue', 'monthly_cost') }} as contribution_margin
    from contribution_margin_logic

)

select * from final