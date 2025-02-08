-- https://datalemur.com/questions/signup-confirmation-rate
with users as (
  SELECT
    user_id,
    count(1) filter (where signup_action = 'Confirmed') as confirmations
  FROM emails e
  left JOIN texts t on e.email_id = t.email_id
  group by user_id
)
select round(count(1) filter (where confirmations >= 1) * 1.0/ count(1), 2) as confirm_rate
from users
-- or
SELECT round(count(signup_action) * 1.0 / count(user_id), 2) as confirm_rate
FROM emails e
left JOIN texts t on e.email_id = t.email_id and signup_action = 'Confirmed'