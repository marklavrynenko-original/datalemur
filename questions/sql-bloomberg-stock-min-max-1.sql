-- https://datalemur.com/questions/sql-bloomberg-stock-min-max-1
with stats as (
  SELECT
    ticker,
    to_char(date, 'Mon-yyyy') as dt,
    min(open) as min_open,
    max(open) as max_open
  FROM stock_prices
  group by ticker, to_char(date, 'Mon-yyyy')
), stats_min as (
  select ticker, dt, min_open,
  rank() over (partition by ticker order by min_open) as rnk
  from stats
),  stats_max as (
  select ticker, dt, max_open,
  rank() over (partition by ticker order by max_open desc) as rnk
  from stats
)
select
  ticker,
  stats_max.dt as highest_mth,
  stats_max.max_open as highest_open,
  stats_min.dt as lowest_mth,
  stats_min.min_open as lowest_open
from stats_min join stats_max using (ticker)
where stats_min.rnk = 1 and stats_max.rnk = 1
