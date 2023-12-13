SELECT * from route;
DELETE FROM route WHERE train_number LIKE "002Э" and station_name = "Зилово" and DATEDIFF(arrival_time, "2022-12-13") = 0;