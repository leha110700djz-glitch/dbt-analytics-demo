-- Витрина: выручка по дням и мерчантам (инкрементально)
{{ config(materialized='incremental', unique_key=['dt','merchant']) }}

select
    date_trunc('day', order_ts)::date as dt,
    merchant,
    count(*)         as orders,
    sum(amount)      as revenue
from {{ ref('stg_orders') }}
{% if is_incremental() %}
where order_ts >= (select coalesce(max(dt), '1900-01-01') from {{ this }})
{% endif %}
group by 1, 2
