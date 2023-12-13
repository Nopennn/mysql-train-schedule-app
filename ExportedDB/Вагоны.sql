SELECT trip.trip_id, q3.train_number AS"Поезда с максимальным кол-вом вагонов", trip.departure_date  AS "Дата отправления" FROM (
SELECT * FROM car
	INNER JOIN
    (
	SELECT MAX(car_number) AS maxx FROM car
    ) max_car
    ON car.car_number = max_car.maxx
    ) q3
    INNER JOIN trip
    ON q3.train_number = trip.train_number
    