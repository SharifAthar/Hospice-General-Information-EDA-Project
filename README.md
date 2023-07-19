# <p align="center">Hospice General Information EDA Project</p>
# <p align="center">![Pic](https://www.ibat.ie/plugins/coursefilter/images/DATA_ANALYTICS.JPG)</p>

**Tools Used: Excel, MySQL, Tableau**

## Introduction
- **What is an EDA?**
  
EDA stands for Exploratory Data Analysis. It's the process where we explore and analyze a dataset to understand its main characteristics and patterns. In simple terms, EDA helps us to dig into the data and find interesting information about it. We look at different aspects of the data, such as its size, and distribution. We also identify any missing or unusual values. By visualizing the data using graphs or charts, we can spot trends or relationships between variables. Overall, EDA helps us get a better understanding of the data before diving into more complex analysis or making decisions based on the information it provides.

- **What is the dataset about?**
  
The "Hospice - General Information" dataset obtained from CMS (Centers for Medicare & Medicaid Services) provides a comprehensive overview of hospice providers. It encompasses crucial details including addresses, phone numbers, and ownership information. This dataset serves as a valuable resource for gaining insights into the characteristics of various hospice facilities. By analyzing this data, researchers, policymakers, and healthcare professionals can better understand the distribution, ownership patterns, and other key aspects of hospice care provision. The dataset offers a foundation for conducting research, improving service delivery, and making informed decisions in the field of end-of-life care.

## Exploratory Data Analysis (EDA)
- **View of the Dataset**
```mysql
SELECT * 
FROM hospice.gen_info
```
![1](https://i.ibb.co/Qcbzr8Q/Screen-Shot-2023-07-18-at-5-10-40-PM.png)

There are 6,091 rows and 12 columns in the dataset

The columns are: CMS_Certification_Number, Facility_Name, Address_Line_1, Address_Line_2, City, State, Zip_Code, County_Name, Phone_Number, CMS_Region, Ownership_Type, Certification_Date

- **Finding Missing Values**
```mysql
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
```
![2](https://i.ibb.co/yRcpKhb/Screen-Shot-2023-07-18-at-5-14-12-PM.png)

There were no missing values in the dataset

- **Q1: How many distinct hospitals are in the dataset?**
```mysql
SELECT 
COUNT(DISTINCT Facility_Name) as num_of_facilities
FROM hospice.gen_info
```
![3](https://i.ibb.co/kKf3SZP/Screen-Shot-2023-07-18-at-5-17-23-PM.png)

- **Q2: How many cities, states, and counties are in the dataset?**
```mysql
SELECT 
COUNT(DISTINCT City) as num_of_cities,
COUNT(DISTINCT State) as num_of_states, 
COUNT(DISTINCT County_Name) as num_of_counties
FROM hospice.gen_info
```
![4](https://i.ibb.co/pxtg1C7/Screen-Shot-2023-07-18-at-5-19-27-PM.png)

After some research, the reason why there's 55 states is because 'GU' (Guam), 'DC' (District of Columbia), 'MP' (Northern Mariana Islands), 'PR' (Puerto Rico), 'VI' (U.S. Virgin Islands) were also included 

- **Q3: How many hospitals are in each state?**
```mysql
SELECT 
DISTINCT state, 
COUNT(facility_name) as num_of_hospitals
FROM hospice.gen_info
GROUP BY state
ORDER BY num_of_hospitals DESC
```
![5](https://i.ibb.co/drJ9MD1/Screen-Shot-2023-07-18-at-5-22-54-PM.png)

- **Q4: How many hospitals were there among each ownership type?
```mysql
SELECT Ownership_Type, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY Ownership_Type;
```
![6](https://i.ibb.co/N1NyrWC/Screen-Shot-2023-07-18-at-5-24-31-PM.png)

- **Q5: How many hospitals were there among each CMS Region?
```mysql
SELECT CMS_Region, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY CMS_Region
ORDER BY Hospital_Count DESC;
```
![7](https://i.ibb.co/DKNgKgD/Screen-Shot-2023-07-18-at-5-26-13-PM.png)

- **Q6: What were the top 5 most common area codes among all hospitals?**
```mysql
SELECT SUBSTRING(Phone_Number, 1, 4) AS Area_Code, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY Area_Code
ORDER BY Hospital_Count DESC
LIMIT 5;
```
![8](https://i.ibb.co/mBRmnW3/Screen-Shot-2023-07-18-at-5-27-43-PM.png)

- **Q7: How many hospitals were certified by each year?**
```mysql
SELECT YEAR(STR_TO_DATE(Certification_Date, '%m/%d/%y')) AS Certification_Year, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY Certification_Year
ORDER BY Certification_Year;
```
![9](https://i.ibb.co/Ld4szJz/Screen-Shot-2023-07-18-at-5-30-05-PM.png)

- **Q8: What were the top 5 cities with the most hospitals?**
```mysql
SELECT City, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY City
ORDER BY Hospital_Count DESC
LIMIT 5;
```
![10](https://i.ibb.co/rHkV77t/Screen-Shot-2023-07-18-at-5-32-15-PM.png)

- **Q9: What were the top 5 counties with the most hospitals?**
```mysql
SELECT County_Name, 
COUNT(*) AS Hospital_Count
FROM hospice.gen_info
GROUP BY County_Name
ORDER BY Hospital_Count DESC
LIMIT 5;
```
![11](https://i.ibb.co/PspfjmK/Screen-Shot-2023-07-18-at-5-33-49-PM.png)

- **Q10: What percentage of hospitals were for-profit and non-profit?**
```mysql
SELECT 
Ownership_Type,
COUNT(*) AS Hospital_Count,
ROUND((COUNT(*)/(SELECT COUNT(*) FROM hospice.gen_info)) * 100, 2) AS Percentage
FROM hospice.gen_info
WHERE Ownership_Type IN ('non-profit', 'for-profit')
GROUP BY Ownership_Type;
```
![12](https://i.ibb.co/qM16ScP/Screen-Shot-2023-07-18-at-5-34-51-PM.png)
