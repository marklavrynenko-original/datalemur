-- https://datalemur.com/questions/alibaba-compressed-mode
SELECT item_count as mode
FROM items_per_order
where order_occurrences = (select max(order_occurrences) from items_per_order)
order by item_count
