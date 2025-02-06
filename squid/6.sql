with worst_game_type as (
  select game_type
  from failure_incidents fi join equipment e on fi.failed_equipment_id = e.id
  group by game_type
  order by count(1) desc
  limit 1
), wost_supplier as (
  select supplier_id
  from equipment e join failure_incidents fi on fi.failed_equipment_id = e.id
  where game_type = (select game_type from worst_game_type)
  group by supplier_id
  order by count(1) desc
  limit 1
), first_failure as (
  select e.id, count(1) as failures, min(failure_date) as date
  from equipment e join failure_incidents fi on fi.failed_equipment_id = e.id
  group by e.id
)
select floor(avg((ff.date - e.installation_date) / 365.2425)) as durability
from equipment e
join failure_incidents fi on fi.failed_equipment_id = e.id
join first_failure ff on ff.id = e.id
where
  	e.game_type = (select game_type from worst_game_type) and
    e.supplier_id = (select supplier_id from wost_supplier)