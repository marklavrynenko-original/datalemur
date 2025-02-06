with coldest_month as (
	select month from monthly_temperatures order by avg_temperature limit 1
),
hottest_month as (
  	select month from monthly_temperatures order by avg_temperature desc limit 1
), results as (
	select shape, extract('month' from date) as month, average_completion_time
	from honeycomb_game
	where date >= NOW() - interval '20 years'
)
select month, shape, avg(average_completion_time) as average_completion_time
from (
  select * from results join coldest_month using (month)
  union
  select * from results join hottest_month using (month)
)
group by month, shape
ORDER BY avg(average_completion_time)