with
    customers as (
        select *
        from {{ ref("dim_customers") }}
    )

    , orders as (
        select *
        from {{ ref("stg_orders") }}
    )

    , orders_details as (
        select *
        from {{ ref("stg_order_details") }}
    )

select
    customers.sk_customer
    , orders.*
from orders
left join customers on orders.customer_id = customers.customer_id
left join orders_details on orders.order_id = orders_details.order_id