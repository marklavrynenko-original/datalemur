-- https://datalemur.com/questions/uncategorized-calls-percentage
select round((SELECT count(1) FROM callers where call_category is NULL or call_category = 'n/a') * 100.0/
(select count(1) from callers), 1)
