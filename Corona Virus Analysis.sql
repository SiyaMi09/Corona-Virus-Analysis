create table corona
(
    Province varchar(30) not null,
	Country_Region varchar(30) not null,
	Latitude float not null,
	Longitude float not null,
	Date date not null,
	Confirmed int not null,
	Deaths int not null,
	Recovered int not null
);

SET datestyle = 'ISO, DMY';

COPY corona 
FROM 'D:/Mentorness Internship/DA/Project 1 - Corona Virus Analysis/Corona Virus Dataset.csv' 
DELIMITER ',' CSV HEADER;

select * from corona

-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
SELECT *
FROM corona
WHERE Province IS NULL OR Country_Region IS NULL OR Latitude IS NULL 
    OR Longitude IS NULL OR Date IS NULL OR Confirmed IS NULL 
    OR Deaths IS NULL OR Recovered IS NULL;


--Q2. If NULL values are present, update them with zeros for all columns. 

-- Q3. check total number of rows
SELECT COUNT(*) AS total_rows
FROM corona;


-- Q4. Check what is start_date and end_date
SELECT MIN(Date) AS start_date, MAX(Date) AS end_date
FROM corona;


-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT EXTRACT(MONTH FROM Date)) AS num_months
FROM corona;

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT EXTRACT(MONTH FROM Date) AS month,
       AVG(Confirmed) AS avg_confirmed,
       AVG(Deaths) AS avg_deaths,
       AVG(Recovered) AS avg_recovered
FROM corona
GROUP BY month
ORDER BY month;


-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
SELECT EXTRACT(MONTH FROM Date) AS month,
       MODE() WITHIN GROUP (ORDER BY Confirmed) AS most_freq_confirmed,
       MODE() WITHIN GROUP (ORDER BY Deaths) AS most_freq_deaths,
       MODE() WITHIN GROUP (ORDER BY Recovered) AS most_freq_recovered
FROM corona
GROUP BY month
ORDER BY month;


-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT EXTRACT(YEAR FROM Date) AS year,
       MIN(Confirmed) AS min_confirmed,
       MIN(Deaths) AS min_deaths,
       MIN(Recovered) AS min_recovered
FROM corona
GROUP BY year
ORDER BY year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT EXTRACT(YEAR FROM Date) AS year,
       MAX(Confirmed) AS max_confirmed,
       MAX(Deaths) AS max_deaths,
       MAX(Recovered) AS max_recovered
FROM corona
GROUP BY year
ORDER BY year;

-- Q10. The total number of case of confirmed, deaths, recovered each month
SELECT EXTRACT(MONTH FROM Date) AS month,
       SUM(Confirmed) AS total_confirmed,
       SUM(Deaths) AS total_deaths,
       SUM(Recovered) AS total_recovered
FROM corona
GROUP BY month
ORDER BY month;

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM(Confirmed) AS total_confirmed,
       AVG(Confirmed) AS avg_confirmed,
       VARIANCE(Confirmed) AS var_confirmed,
       STDDEV(Confirmed) AS stdev_confirmed
FROM corona;

-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM(Deaths) AS total_deaths,
       AVG(Deaths) AS avg_deaths,
       VARIANCE(Deaths) AS var_deaths,
       STDDEV(Deaths) AS stdev_deaths
FROM corona;

-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
SELECT SUM(Recovered) AS total_recovered,
       AVG(Recovered) AS avg_recovered,
       VARIANCE(Recovered) AS var_recovered,
       STDDEV(Recovered) AS stdev_recovered
FROM corona;

-- Q14. Find Country having highest number of the Confirmed case
SELECT Country_Region, MAX(Confirmed) AS max_confirmed
FROM corona
GROUP BY Country_Region
ORDER BY max_confirmed DESC
LIMIT 1;

-- Q15. Find Country having lowest number of the death case
SELECT Country_Region, sum(deaths) AS total_deaths
FROM corona
GROUP BY Country_Region
ORDER BY total_deaths 
LIMIT 1;

-- Q16. Find top 5 countries having highest recovered case
SELECT Country_Region, SUM(Recovered) AS total_recovered
FROM corona
GROUP BY Country_Region
ORDER BY total_recovered DESC
LIMIT 5;