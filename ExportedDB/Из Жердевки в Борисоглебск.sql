SELECT 
          trip.train_number, 
          trip.arrival_station,
          trip.departure_station,
          trip.departure_date
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
          ) all_trains_between_stations ON trip.train_number = all_trains_between_stations.train_number;