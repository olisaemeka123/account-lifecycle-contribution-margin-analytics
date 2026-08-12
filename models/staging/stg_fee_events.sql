
with source as (

        select * from {{source ('raw_alcm_analytics','fee_events')}}

),

renamed as (

        select 
            fee_id,
            account_id,
            cast(fee_date as date) as fee_date,
            fee_type,
            cast (fee_amount as numeric) as fee_amount,
            
        
    from source
)

select * from renamed