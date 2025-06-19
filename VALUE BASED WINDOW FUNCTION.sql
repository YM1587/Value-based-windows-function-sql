-- VALUED BASED WINDOW FUNCTION
-- Overview
-- Say we want to investigate how the percentage of managed drinking water changes from one year to the next in 
-- every country. We can add a new column with the previous year's percentage of managed drinking water using 
-- the LAG() function. This is a value-based window function that extracts the value of a specific column from 
-- a previous row.

SELECT 
	Country_name,
    Time_period,
    Pct_managed_drinking_water_services
FROM
	access_to_basic_services;
    

-- 1. Add a new column with the previous year's percentage of managed drinking water.
-- Add the line with the LAG() function to the base query above to extract the previous year's percentage of 
-- managed drinking water within each country. Store the results in a new column.

SELECT 
	Country_name,
    Time_period,
    Pct_managed_drinking_water_services,
    LAG(Pct_managed_drinking_water_services) OVER(partition by Country_name ORDER BY Time_period asc) AS 
    Pre_year_Pct_managed_drinking_water_services
FROM
	access_to_basic_services;

-- Determine the Annual Rate of Change between consecutive years.
-- Let’s go further and determine the Annual Rate of Change between consecutive years. That is, the 
-- difference between Pct_managed_drinking_water_services and Prev_year_pct_managed_drinking_water_services.

-- Therefore, we subtract the previous percentage of managed drinking water from the current percentage of 
-- managed drinking water.

-- The query will work similarly to the previous one, except that we reuse the LAG() function to calculate 
-- the Annual Rate of Change.

SELECT 
	Country_name,
    Time_period,
    Pct_managed_drinking_water_services,
    LAG(Pct_managed_drinking_water_services) OVER(partition by Country_name ORDER BY Time_period asc) AS 
    Pre_year_Pct_managed_drinking_water_services,Pct_managed_drinking_water_services -
    LAG(Pct_managed_drinking_water_services) OVER(partition by Country_name ORDER BY Time_period asc) AS 
    ARC_pct_managed_drinking_water_services
FROM
	access_to_basic_services;

-- NOTE: SQL does not allow us to use the alias we had created within the same SELECT statement directly. 
-- Hence, we have to explicitly write the lag function again.