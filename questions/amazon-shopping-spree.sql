-- https://datalemur.com/questions/amazon-shopping-spree
select user_id
from (
  SELECT
    user_id,
    transaction_date,
    lag(transaction_date, 1) over (partition by user_id) as p1,
    lag(transaction_date, 2) over (partition by user_id) as p2
  FROM transactions
  order by user_id, transaction_date
) A
where transaction_date - p1 = interval '1 day' and p1 - p2 = interval '1 day'
order by user_id
