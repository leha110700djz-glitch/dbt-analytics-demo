-- Staging: очистка и типизация сырых заказов
with src as (
    select * from {{ ref('raw_orders') }}
)
select
    cast(order_id as bigint)      as order_id,
    cast(order_ts as timestamp)   as order_ts,
    lower(trim(merchant))         as merchant,
    cast(amount as numeric(12,2)) as amount
from src
where amount >= 0
