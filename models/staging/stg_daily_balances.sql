
with source as (

        select * from {{source ('raw_alcm_analytics','daily_balances')}}

),

renamed as (

        select 
            account_id,
            cast(balance_date as date) as balance_date,
            cast(balance_amount as numeric) as balance_amount,
        
    from source
)

select * from renamed