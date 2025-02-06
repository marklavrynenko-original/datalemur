with interactions as (
  select 456 as p1, case when player1_id = 456 then player2_id else player1_id end as p2
  from Daily_interactions
  where player1_id = 456 or player2_id = 456
), top_companion as (
  select p1, p2, count(1) as interactions
  from interactions
  group by p1, p2
  order by count(1) desc
  limit 1
)
select p1.first_name as name1, p2.first_name as name2, t.interactions
from top_companion t
join player p1 on t.p1 = p1.id
join player p2 on t.p2 = p2.id