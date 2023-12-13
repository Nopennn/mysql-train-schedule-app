/* Информация о вагонах класса 2-3 без животных из тех поездов, которые проезжают через самую популярную станцию */ 
SELECT car.* FROM car 
  INNER JOIN (
    SELECT * from (
        SELECT train_number FROM route WHERE 
          station_name IN (
            SELECT q1.station_name FROM (
                SELECT station_name, COUNT(*) as sum FROM (
                    SELECT train_number, station_name FROM route 
                    GROUP BY train_number, station_name
                  ) uniq_trips 
                GROUP BY station_name 
                ORDER BY sum DESC 
                LIMIT 1
              ) q1 INNER JOIN (
                SELECT station_name, COUNT(*) as sum FROM (
                    SELECT train_number, station_name FROM route 
                    GROUP BY train_number, station_name
                  ) uniq_trips GROUP BY station_name
              ) q2 ON q1.sum = q2.sum
          )
      ) q3 
    GROUP BY train_number
  ) q4 ON car.train_number = q4.train_number 
WHERE car_type IN ("CL2", "CL3") AND pets_allowed LIKE "NO";