drop table if exists green;
create temp table green as (
	select g.*
	, oz."Borough" as "OB"
	, oz."Zone" as "OZ"
	, dz."Borough" as "DB"
	, dz."Zone" as "DZ"
	from green_taxi_data g
	left join zones oz
	on g."PULocationID" = oz."LocationID"
	left join zones dz
	on g."DOLocationID" = dz."LocationID");

select count(1) from green
where "lpep_pickup_datetime"::date = '2019-01-15'
and "lpep_dropoff_datetime"::date = '2019-01-15';

select "lpep_pickup_datetime"::date
from green
where "trip_distance" = (select max("trip_distance") from green);

select count(1), passenger_count
from green
where "lpep_pickup_datetime"::date = '2019-01-01'
and passenger_count in (2, 3)
group by 2;

select "DZ" from green
where tip_amount = (select max(tip_amount) from green where "OZ" = 'Astoria');