select MIN(t.time) as Min_time
FROM (SELECT timediff (f.arrival_time, route.arrival_time) as "time"
FROM route join route f 
ON route.route_id = f.route_id - 1
WHERE route.train_number = "001И" and f.train_number = "001И"
	AND route.trip_id = f.trip_id) as t