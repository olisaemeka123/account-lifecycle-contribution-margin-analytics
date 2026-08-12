with source as (

        select * from {{ref ('cost_allocation')}}

),

renamed as (

        select 
            tier,
            cast(monthly_cost_per_account as numeric) as monthly_cost_per_account,
        
        from source
)

select * from renamed