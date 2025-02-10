-- https://datalemur.com/questions/sql-swapped-food-delivery
select
  order_id as corrected_order_id,
  --item, prev, next,
  case
    when order_id % 2 = 1 and next is not NULL then next
    when order_id % 2 = 0 and prev is not NULL then prev
    else item
  end as item
from (
  SELECT
    order_id, item, lag(item) over () as prev, lead(item) over () as next
  FROM orders
) A
