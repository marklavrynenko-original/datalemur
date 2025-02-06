with missing_guards as (
  select
	g.id, g.code_name, g.status,
	r.last_check_time as last_seen,
	c.movement_detected_time as spotted_time,
	c.location,
	c.movement_detected_time - r.last_check_time as time_diff
  from guard g
  join room r on g.assigned_room_id =r.id
  left join camera c on g.id = c.guard_spotted_id
  where c.movement_detected and r.isvacant
)
select *,
(select max(spotted_time) - min(spotted_time) from missing_guards) as time_first_last
from missing_guards
order by id