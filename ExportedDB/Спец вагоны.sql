select train_number, car_number
FROM car
WHERE pets_allowed = "NO" AND refund_allowed = "YES" AND car_type = "CL1"