
with source as (

        select * from {{source ('raw_alcm_analytics','transactions')}}

),

renamed as (

        select 
            transaction_id,
            account_id,
            cast(transaction_date as date) as transaction_date,
            transaction_type,
            cast (amount as numeric) as amount,
            
        
    from source
)

select * from renamed