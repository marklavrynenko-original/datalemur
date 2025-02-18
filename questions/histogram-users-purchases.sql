-- https://datalemur.com/questions/histogram-users-purchases
select transaction_date, user_id, purchase_count
from (
  SELECT
    transaction_date,
    user_id,
    rank() over (partition by user_id order by transaction_date desc) as num,
    count(1) as purchase_count
  FROM user_transactions
  group by user_id, transaction_date
) as A
where num = 1
order by transaction_date
