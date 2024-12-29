with
    orders as (
        select *
        from {{source('northwind','orders')}}
        {% if env_var("DBT_TARGET_SCHEMA") == 'dev' %}
  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  -- (If event_time is NULL or the table is truncated, the condition will always be true and load all records)
  limit 100
        {% endif %}
    )

select *
from orders