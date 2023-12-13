SELECT * FROM (
SELECT q2.trip_id, q2.train_number, q2.departure_time, q2.arrival_time, tmp.station_name as depature_station, tmp2.station_name as arrival_station FROM (
    SELECT trip_id, train_number, MIN(arrival_time) as departure_time, MAX(arrival_time) as arrival_time FROM (
        SELECT * FROM route
        ORDER BY trip_id, arrival_time
  ) q1
  GROUP BY trip_id, train_number
  having q1.trip_id IN (SELECT DISTINCT trip_id FROM route
      WHERE station_name LIKE "%Жердевка%")
) q2 JOIN 
(SELECT trip_id, station_name, arrival_time FROM route) tmp ON q2.trip_id = tmp.trip_id and q2.departure_time = tmp.arrival_time
JOIN (SELECT trip_id, station_name, arrival_time FROM route) tmp2 on q2.trip_id = tmp2.trip_id and q2.arrival_time = tmp2.arrival_time
) аоо
WHERE DATE(departure_time) = "2022-12-01";