select *
from player
where status='alive' and debt > 400000000 and
((age > 65) or (vice = 'Gambling' and not has_close_family))

