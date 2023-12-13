
SELECT * FROM trip JOIN (
SELECT tmp1.trip_id, tmp1.train_number  FROM (
SELECT * FROM route WHERE trip_id IN (
  SELECT trip_id FROM route 
            WHERE station_name LIKE "%Поворино%" OR station_name LIKE "%Жердевка%"
            GROUP BY train_number 
            HAVING COUNT(*) > 1
) AND station_name LIKE "%Поворино%" OR station_name LIKE "%Жердевка%" 
 ORDER BY trip_id, arrival_time ) tmp1 JOIN (
SELECT * FROM route WHERE trip_id IN (
  SELECT trip_id FROM route 
            WHERE station_name LIKE "%Поворино%" OR station_name LIKE "%Жердевка%" 
            GROUP BY train_number 
            HAVING COUNT(*) > 1
) AND station_name LIKE "%Поворино%"  OR station_name LIKE "%Жердевка%" 
 ORDER BY trip_id, arrival_time DESC
) tmp2 ON tmp1.station_name LIKE "%Поворино%" and tmp2.station_name LIKE "%Жердевка%" AND tmp1.trip_id = tmp2.trip_id
 WHERE timediff(tmp2.arrival_time, tmp1.arrival_time) > 0
 ) q1 ON trip.trip_id = q1.trip_id 
 JOIN route as l on q1.trip_id = l.trip_id AND arrival_station = l.station_name
JOIN route as r on q1.trip_id = r.trip_id AND departure_station = r.station_name;