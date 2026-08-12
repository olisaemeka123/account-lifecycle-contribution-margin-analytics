
with source as (

        select * from {{source ('raw_alcm_analytics','account_status_history')}}

),

renamed as (

        select 
            account_id,
            status,
            tier,
            cast(effective_date as date) as effective_date
        
    from source
)

select * from renamed