--1. rows in data_analysts_jobs 
SELECT COUNT(*) AS count_rows 
FROM data_analyst_jobs;
--Answer: 1793

--2.first 10 rows. What company is associated with the job posting on the 10th row.
SELECT * FROM data_analyst_jobs
LIMIT 10;
-- Answer: ExxonMobil


--3.count of  postings in Tennessee
SELECT COUNT(title) AS countofpostings_TN 
FROM data_analyst_jobs
WHERE location = 'TN';
--Answer: 21

-- Count of postings in either Tennessee or Kentucky?
SELECT COUNT(title) AS countofpostings_TN_KY 
FROM data_analyst_jobs
WHERE location = 'TN' OR location ='KY';
--Answer: 27

--4.Count of postings in Tennessee have star rating above 4
SELECT COUNT(title) AS count_TN_rating4 
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating >4;
--Answer: 3

--5.Count of postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(title) AS count_review 
FROM data_analyst_jobs
WHERE review_count >= 500 AND review_count <= 1000;
--Answer: 151

--6.Average star rating for companies in each state 
SELECT location AS state, ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL 
GROUP BY location 
ORDER BY avg_rating DESC;
--Answer: NE 

--7.unique job titles
SELECT DISTINCT title
FROM data_analyst_jobs;

--count of unique titles 
SELECT COUNT(DISTINCT title) as count_job_titles
FROM data_analyst_jobs;
--Answer: 881


--8.count unique job titles for California companies
SELECT COUNT(DISTINCT title) AS count_California_job_title
FROM data_analyst_jobs
WHERE location ='CA';
--Answer: 230


--9.company and its average star rating that have more than 5000 reviews.
SELECT DISTINCT company, ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company;

--count of companies with reviews > 5000 
SELECT COUNT(DISTINCT company)
FROM data_analyst_jobs
WHERE review_count > 5000
--Answer: 40

--10.Add code to order the query in #9 from highest to lowest average star rating
--Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? 
--What is that rating?
SELECT DISTINCT company, ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_rating DESC;
--Answer: 4.20- American Express, General motors,kaiser Permanente
--microsoft,nike,uniliver


--11.job titles that contain the word ‘Analyst’
SELECT DISTINCT title 
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';

--How many different job titles are there
SELECT COUNT(DISTINCT title) AS count_title_analyst 
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';
--Answer: 774

--12.count different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 
--What word do these positions have in common
SELECT DISTINCT title 
FROM data_analyst_jobs
WHERE (title NOT ILIKE '%analyst%') 
	AND  (title NOT ILIKE '%analytics%');
--Answer: 4 and Tableau


--**Bonus. You want to understand which jobs requiring SQL are hard to fill. 
--Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
 --Disregard any postings where the domain is NULL.
 --Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top.
 --Which industries are in the top 4?
SELECT domain, COUNT(title) AS count_SQL_hardfill
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%' 
	AND days_since_posting > 21
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY count_SQL_hardfill DESC
LIMIT 4;
--Answer: Internet and Software, Banks and Financial Services, 
--Consulting and Business Services,Health Care
