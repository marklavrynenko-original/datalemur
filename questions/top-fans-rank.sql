-- https://datalemur.com/questions/top-fans-rank
with ranking as (
  SELECT artist_name, r.song_id, day
  FROM artists a
  join songs s on a.artist_id = s.artist_id
  join global_song_rank r on s.song_id = r.song_id
  where r.rank <= 10
), top_artists as (
  select
    artist_name,
    dense_rank() over (order by count(1) desc) as artist_rank
  from ranking
  group by artist_name
)
select *
from top_artists
where artist_rank <= 5
order by artist_rank