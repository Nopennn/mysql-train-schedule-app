
UPDATE car
SET car_type = "CL1"
WHERE train_number LIKE "006Ф" and pets_allowed = "NO";
SELECT * FROM car
WHERE train_number LIKE "006Ф";