-- https://datalemur.com/questions/sql-highest-grossing
with products as (
  SELECT
    category,
    product,
    sum(spend) as total_spend,
    rank() over (partition by category order by sum(spend) desc) as rank_in_category
  FROM product_spend
  where extract(year from transaction_date) = 2022
  group by category, product
)
select category, product, total_spend
from products
where rank_in_category <= 2