-- https://datalemur.com/questions/international-call-percentage
with calls as (
  SELECT
    ci.country_id as caller_country,
    ri.country_id as receiver_country
  FROM phone_calls pc
  JOIN phone_info ci on pc.caller_id = ci.caller_id
  JOIN phone_info ri on pc.receiver_id = ri.caller_id
)
select round(
  (select count(1) from calls where caller_country != receiver_country) * 100.0/
  (select count(1) from calls), 1
)