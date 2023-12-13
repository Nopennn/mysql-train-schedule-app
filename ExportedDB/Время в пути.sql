SELECT TIMEDIFF(
	(
	SELECT arrival_time FROM route
		WHERE route_id = 1
    ),
    (
    SELECT arrival_time FROM route
		WHERE route_id = 2
    )
);