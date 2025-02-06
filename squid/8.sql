with pushed_players as (
  select id, first_name, last_name, game_id, last_moved_time_seconds as hesitation
  from player
  where not survived and death_description ilike '%pushed%'
), top_games as ( -- 26
  select game_id, avg(hesitation) as avg_hesitation
  from pushed_players
  group by game_id
  order by avg(hesitation) desc
  limit 1
)
select pp.id, pp.first_name, pp.last_name, pp.hesitation
from pushed_players pp
join top_games tg on pp.game_id = tg.game_id
order by hesitation desc
limit 1
