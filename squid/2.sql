select A.*, A.rations <= (select * from rations) as sufficient
from (
  select floor(0.9 * count(*)) as rations
  from player
  where status = 'alive' and not isInsider
) A