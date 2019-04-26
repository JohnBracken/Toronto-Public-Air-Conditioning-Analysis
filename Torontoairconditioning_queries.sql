
-- Create a table of Toronto public air conditioned places.
CREATE TABLE torontoair (
Location_type_code varchar(255),
Location_type_desc varchar(255),
Location_code varchar(255),
Location_desc varchar(255),
Location_name varchar(255),
Address varchar(255),	
Phone varchar(15),	
Notes varchar(255),	
Lat	decimal(8,6),
Lon decimal(8,6)
);

-- Get all the rows of the table and display.
SELECT * FROM torontoair;

-- Select only air conditioned locations that are libraries.
SELECT * FROM torontoair
WHERE Location_code = 'LIBRARY';

-- Get the minimum latitude from the latitude column
SELECT MIN(Lat) AS 'Min_Latitude'
FROM torontoair;

-- Select the row that contains the minimum value for latitude
SELECT * FROM torontoair
WHERE Lat = (SELECT MIN(Lat) FROM torontoair);

-- Insert a new row into the table
INSERT INTO torontoair
VALUES ('COOL_LOCN', 'Cooling Location', 'LIBRARY', 'Library', 'Weaksauce',
'123 Weaksauce Ave', '555-123-4567', 'fake',43.181818,-79.933445);

-- Count the number of unique location codes in the table
SELECT COUNT(DISTINCT Location_code) FROM torontoair; 

-- Select rows with only location names that start with B.
SELECT * FROM torontoair
WHERE Location_name LIKE 'B%';

-- Select rows with Lat > 43.7 and Lon < -79.3
SELECT * FROM torontoair
WHERE Lat > 43.7 AND Lon < -79.3;

-- Count the number of rows
SELECT COUNT(Address) FROM torontoair;

/* Order all rows by increasing latitude, with increasing 
as a secondary criterion. */
SELECT * FROM torontoair
ORDER BY Lat, Lon ASC;

-- Replace all blanks in the Notes column with NULL values.
UPDATE torontoair 
SET Notes = NULL 
WHERE Notes = '';

-- Select all rows in which the Notes column is not NULL.
SELECT * FROM torontoair
WHERE Notes IS NOT NULL;

-- Delete the row with the fake entry that was added earlier.
DELETE FROM torontoair
WHERE Notes = 'fake';

-- Select the top 5 rows from torontoair
SELECT * FROM torontoair
LIMIT 5;

-- Select only rows of designation Cooling Centre
SELECT * FROM torontoair
WHERE location_type_desc IN('Cooling Centre');

-- Select cooling locations with longitude between -79.3 and -79.1
SELECT * FROM torontoair
WHERE Lon BETWEEN -79.3 AND -79.1;

-- Join two tables together based on address.
SELECT * FROM torontoair
LEFT JOIN addresses
ON torontoair.Address = addresses.Address
ORDER BY torontoair.Address;

/* Count the number of addresses in each type of location description.
Only select values where the count of number of addresses from a 
particular location group is greater than 2. */
Select COUNT(Address), Location_code FROM torontoair
GROUP BY Location_code
HAVING COUNT(Address) > 2
ORDER BY (SELECT COUNT(Address));

-- Create a copy of the toronto air conditioning table.
CREATE TABLE testtabLatplusLonle 
SELECT * FROM torontoair;

-- Add a new column to the table, latitude plus longitude.
ALTER TABLE torontoair
ADD LatplusLon decimal(8,6);

-- Set this new column to the sum of latitude plus longitude.
UPDATE torontoair
SET LatplusLon = Lat + Lon;

-- Create an index on the latitude column.
CREATE INDEX idx_lat
ON torontoair (Lat);

-- Show the index
SHOW INDEX  FROM torontoair;

-- Create a virtual table view of the airconditioning data.
CREATE View airview AS
SELECT * FROM torontoair;