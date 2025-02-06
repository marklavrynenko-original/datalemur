with teams as (
  select team_id, count(1) as size, avg(age) as avg_age
  from player
  where status = 'alive'
  group by team_id
)
select
	team_id,
	avg_age,
	case
		when avg_age < 40 then 'Fit'
		when avg_age > 50 then 'Elderly'
		else 'Grizzled'
	end as age_group,
	rank() over (order by avg_age desc)
from teams
where size = 10
