with game as (
  select start_time, end_time
  from game_schedule
  where type = 'Squid Game'
  order by date desc
  limit 1
), missing_guard as (
  select g.id, l.door_location, l.access_time, g.shift_start, g.shift_end
  from guard g
  join daily_door_access_logs l on g.id = l.guard_id
  join game on g.shift_start <= game.end_time and g.shift_end >= game.start_time
  where g.assigned_post != l.door_location
)
select g.id, l.access_time
from guard g
join daily_door_access_logs l on g.id = l.guard_id
join missing_guard mg on l.door_location = mg.door_location
cross join game
where g.id not in (select id from missing_guard) and
l.access_time between game.start_time and game.end_time
order by l.access_time