-- https://datalemur.com/questions/user-retention
with user_activity as (
  SELECT
    user_id,
    extract(year from event_date) as year,
    extract(month from event_date) as month,
    count(1) as events
  FROM user_actions
  group by user_id, extract(year from event_date), extract(month from event_date)
), july_active_users as (
  select
    year,
    month,
    user_id,
    events,
    lag(events) over (partition by user_id order by year, month) as prev_events
  from user_activity
)
select month, count(user_id) as monthly_active_users
from july_active_users
where year = 2022 and month = 7 and prev_events > 0
group by month
