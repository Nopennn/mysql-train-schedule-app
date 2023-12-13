SELECT train_number,
       count(*) AS c
FROM route
WHERE station_name = "Борисоглебск" OR station_name = "Лиски"
GROUP BY train_number
HAVING c > 1;