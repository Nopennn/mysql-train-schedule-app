/* Время в пути каждого поезда */
SELECT 
  q1.trip_id, 
  q1.train_number, 
  q1.arrival_station, 
  q1.departure_station, 
  q2.arrival_time AS arrival_time, 
  q3.arrival_time AS departure_time, 
  timediff(q3.arrival_time, q2.arrival_time) AS travel_time 
  FROM (
		SELECT trip_id, train_number, arrival_station, departure_station FROM trip
		GROUP BY train_number, arrival_station, departure_station
	) q1
	INNER JOIN
    (
		SELECT train_number, station_name, arrival_time FROM route 
		GROUP BY train_number, station_name
    ) q2
    ON q1.train_number = q2.train_number AND q1.arrival_station = q2.station_name
    JOIN (
		SELECT train_number, station_name, arrival_time FROM route 
		GROUP BY train_number, station_name
    ) q3
    ON q1.train_number = q3.train_number AND q1.departure_station = q3.station_name;