SELECT 
  final_query.train_number, 
  final_query.car_number 
FROM 
  (
    SELECT 
      car.train_number, 
      car.car_number, 
      car.pets_allowed 
    FROM 
      car 
      RIGHT OUTER JOIN (
        SELECT 
          trip.train_number, 
          trip.number_of_cars 
        FROM 
          trip 
          RIGHT OUTER JOIN (
            SELECT 
              train_number, 
              route_id, 
              count(*) AS c 
            FROM 
              route 
            WHERE 
              station_name = "Борисоглебск" 
              OR station_name = "Жердевка" 
            GROUP BY 
              train_number 
            HAVING 
              c > 1
          ) all_trains_between_stations ON trip.train_number = all_trains_between_stations.train_number
      ) trip_query ON car.train_number = trip_query.train_number
  ) final_query 
WHERE 
  pets_allowed = "YES";
