SELECT trip.train_number, trip.departure_station, trip.arrival_station, trip.departure_date, route.arrival_time FROM trip 
	JOIN route ON route.trip_id = trip.trip_id
    WHERE  route.train_number = "001А"
    GROUP BY departure_date;