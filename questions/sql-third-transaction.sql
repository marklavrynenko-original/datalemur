-- https://datalemur.com/questions/sql-third-transaction
select user_id, spend, transaction_date
from (
  SELECT *,
  rank() over (partition by user_id order by transaction_date) as tr_number
  FROM transactions
) A
where tr_number = 3