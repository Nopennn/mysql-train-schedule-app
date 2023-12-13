SELECT DISTINCT train_number, COUNT(*) AS "кол-во_станций_в_маршруте" FROM route
	GROUP BY train_number, trip_id;
    
	