-- View of the entire dataset
SELECT * 
FROM hospice.gen_info

-- Finding missing values in the dataset
SELECT
    SUM(CASE WHEN CMS_Certification_Number IS NULL THEN 1 ELSE 0 END) AS Missing_CMS_Certification_Number,
    SUM(CASE WHEN Facility_Name IS NULL THEN 1 ELSE 0 END) AS Missing_Facility_Name,
    SUM(CASE WHEN Address_Line_1 IS NULL THEN 1 ELSE 0 END) AS Missing_Address_Line_1,
    SUM(CASE WHEN Address_Line_2 IS NULL THEN 1 ELSE 0 END) AS Missing_Address_Line_2,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS Missing_City,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS Missing_State,
    SUM(CASE WHEN Zip_Code IS NULL THEN 1 ELSE 0 END) AS Missing_Zip_Code,
    SUM(CASE WHEN County_Name IS NULL THEN 1 ELSE 0 END) AS Missing_County_Name,
    SUM(CASE WHEN Phone_Number IS NULL THEN 1 ELSE 0 END) AS Missing_Phone_Number,
    SUM(CASE WHEN CMS_Region IS NULL THEN 1 ELSE 0 END) AS Missing_CMS_Region,
    SUM(CASE WHEN Ownership_Type IS NULL THEN 1 ELSE 0 END) AS Missing_Ownership_Type,
    SUM(CASE WHEN Certification_Date IS NULL THEN 1 ELSE 0 END) AS Missing_Certification_Date
FROM hospice.gen_info;

-- Count of facilities 
SELECT 
COUNT(DISTINCT Facility_Name) as num_of_facilities
FROM hospice.gen_info

-- Count of cities, states, and counties 
SELECT 
COUNT(DISTINCT City) as num_of_cities,
COUNT(DISTINCT State) as num_of_states, 
COUNT(DISTINCT County_Name) as num_of_counties
FROM hospice.gen_info

-- Number of hospitals in each state 
SELECT 
DISTINCT state, 
COUNT(facility_name) as num_of_hospitals
FROM hospice.gen_info
GROUP BY state
ORDER BY num_of_hospitals DESC

-- Number of hospitals by ownership type 
SELECT Ownership_Type, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY Ownership_Type;

-- Number of hospitals by each CMS region 
SELECT CMS_Region, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY CMS_Region
ORDER BY Hospital_Count DESC; 

-- Percentage of hospitals that have a missing phone number
SELECT (COUNT(*)/(SELECT COUNT(*) FROM hospice.gen_info)) * 100 AS Missing_PhoneNumber_Percentage
FROM hospice.gen_info
WHERE Phone_Number IS NULL;

-- Top 5 most common phone number area code among all hospitals
SELECT SUBSTRING(Phone_Number, 1, 4) AS Area_Code, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY Area_Code
ORDER BY Hospital_Count DESC
LIMIT 5;

-- Number of hospitals certified by each year
SELECT YEAR(STR_TO_DATE(Certification_Date, '%m/%d/%y')) AS Certification_Year, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY Certification_Year
ORDER BY Certification_Year;

-- Top 5 cities with the most hospitals
SELECT City, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY City
ORDER BY Hospital_Count DESC
LIMIT 5;

-- Top 5 counties with the most hospitals 
SELECT County_Name, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY County_Name
ORDER BY Hospital_Count DESC
LIMIT 5;

-- Percentage of for-profit and non-profit hospitals 
SELECT 
Ownership_Type,
COUNT(*) AS Hospital_Count,
ROUND((COUNT(*)/(SELECT COUNT(*) FROM hospice.gen_info)) * 100, 2) AS Percentage
FROM hospice.gen_info
WHERE Ownership_Type IN ('non-profit', 'for-profit')
GROUP BY Ownership_Type;


















