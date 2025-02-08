-- https://datalemur.com/questions/time-spent-snaps
with age_activity_time as (
  SELECT ab.age_bucket, a.activity_type, sum(time_spent) as time
  FROM activities a join age_breakdown ab on a.user_id = ab.user_id
  where a.activity_type in ('send', 'open')
  group by ab.age_bucket, a.activity_type
), age_time as (
  select
    age_bucket,
    sum(time) filter (where activity_type = 'send') as send_time,
    sum(time) filter (where activity_type = 'open') as open_time,
    sum(time) as total_time
  from age_activity_time
  group by age_bucket
)
select
  age_bucket,
  round(100. * send_time / total_time, 2) as send_perc,
  round(100. * open_time / total_time, 2) as open_perc
from age_time
