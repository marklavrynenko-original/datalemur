-- https://datalemur.com/questions/odd-even-measurements
select
  measurement_day,
  sum(measurement_value) filter (where pos % 2 = 1) as odd_sum,
  sum(measurement_value) filter (where pos % 2 = 0) as even_sum
from (
  SELECT
    date(measurement_time) as measurement_day,
    measurement_value,
    rank() over (partition by date(measurement_time) order by measurement_time) as pos
  FROM measurements
) A
group by measurement_day
