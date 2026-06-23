CREATE DATABASE ola;

CREATE TABLE bookings(
	Date DATE ,
	Time TIME,
	Booking_ID VARCHAR(100),
	Booking_Status VARCHAR(100),
	Customer_ID VARCHAR(100),
	Vehicle_Type VARCHAR(50),
	Pickup_Location VARCHAR(200),
	Drop_Location VARCHAR(200),
	V_TAT VARCHAR(10),
	C_TAT VARCHAR(10),
	Canceled_Rides_by_Customers VARCHAR(200),
	Canceled_Rides_by_Driver VARCHAR(200),
	Incomplete_Rides VARCHAR(10),
	Incomplete_Rides_Reason	VARCHAR(100),
	Booking_Value INT,
	Payment_Method  VARCHAR(100),
	Ride_Distance  INT,
	Driver_Ratings	VARCHAR(10),
	Customer_Rating	VARCHAR(10),
	Vehicle_Images TEXT

);

SELECT*FROM bookings ;

--q1. Retrieve all successful bookings:
SELECT * FROM bookings
WHERE Booking_status = 'Success';

--q2. Find the average ride distance for each vehicle type:
SELECT 
	Vehicle_Type ,
	AVG(Ride_Distance):: DECIMAL(10,2) AS avg_distance 
FROM 
	bookings 
GROUP BY Vehicle_Type;


--q3. Get the total number of cancelled rides by customers:
SELECT 
	COUNT(*) 
FROM
	bookings 
WHERE Booking_status = 'Canceled by Customer';
	

--q4. List the top 5 customers who booked the highest number of rides:
SELECT
	Customer_ID,
	COUNT(Booking_ID) AS total_bookings
FROM
	bookings
GROUP BY Customer_ID 
ORDER BY total_bookings DESC
LIMIT 5;

--q5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT
	COUNT(*) 
FROM 
	bookings 
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';

--q6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT	
	MAX(Driver_Ratings) AS max_ratings,
	MIN(Driver_Ratings) AS min_ratings
FROM
	bookings
WHERE Vehicle_Type='Prime Sedan'
AND Driver_Ratings != 'NA';

--q7. Retrieve all rides where payment was made using UPI:
SELECT * FROM bookings
WHERE Payment_Method = 'UPI' ;
	
--q8. Find the average customer rating per vehicle type:
WITH rating_cte AS(
SELECT
	 	Vehicle_Type,
		Customer_Rating:: NUMERIC AS Customer_Rating
FROM
	bookings
WHERE Customer_Rating != 'NA'
)
SELECT
		r.vehicle_Type,
		AVG(r.Customer_Rating):: DECIMAL(10,2)AS avg_rating
FROM rating_cte r
GROUP BY Vehicle_Type ;


--q9. Calculate the total booking value of rides completed successfully:
SELECT
		SUM(Booking_Value) AS booking_value 
FROM
	bookings
WHERE Booking_Status = 'Success';


--q10. List all incomplete rides along with the reason:
SELECT
	Booking_ID,
	Incomplete_Rides_Reason
FROM
	bookings
WHERE Incomplete_Rides = 'Yes';
	
