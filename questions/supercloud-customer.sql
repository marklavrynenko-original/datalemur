-- https://datalemur.com/questions/supercloud-customer
with product_categories as (
  SELECT distinct product_category
  FROM products
)
select customer_id
from (
  select customer_id, count(distinct product_category) as cats
  from customer_contracts c join products p using (product_id)
  group by customer_id
) A
where A.cats = (select count(1) from product_categories)