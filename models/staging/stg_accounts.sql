
with source as (

        select * from {{source ('raw_alcm_analytics','accounts')}}

),

renamed as (

        select 
            account_id,
            customer_id,
            cast(signup_date as date) as signup_date,
            current_status,
            current_tier
        
    from source
)

select * from renamed