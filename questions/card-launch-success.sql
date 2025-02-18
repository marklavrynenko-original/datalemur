-- https://datalemur.com/questions/card-launch-success
select card_name, issued_amount
from (
  SELECT card_name, issued_amount, rank() over (partition by card_name order by issue_year, issue_month)
  FROM monthly_cards_issued
) A
where rank = 1
order by issued_amount desc
