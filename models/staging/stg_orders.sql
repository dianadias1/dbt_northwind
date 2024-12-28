{{config(materialized='incremental', unique_key = 'order_id')}}

with
    orders as (
        select *
        from {{source('northwind','orders')}}
        {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- (If event_time is NULL or the table is truncated, the condition will always be true and load all records)
  where order_date >= (select max(order_date) from {{ this }})

        {% endif %}
    )

select *
from orders