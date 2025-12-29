SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    month
ORDER BY
    job_posted_count DESC;




SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS avg_yearly_salary,
    AVG(salary_hour_avg) AS avg_hourly_salary
FROM 
    job_postings_fact
WHERE 
    job_posted_date > '2023-06-01'
GROUP BY 
    job_schedule_type;


SELECT
job_id,
EXTRACT(MONTH FROM job_posted_date) AS posted_month,
AVG(salary_hour_avg) AS avg_salary_hour_avg,
AVG(salary_year_avg) AS avg_salary_year_avg
FROM
job_postings_fact
WHERE
job_posted_date > '2023-06-01'
GROUP BY
job_id,
EXTRACT(MONTH FROM job_posted_date)
ORDER BY
avg_salary_year_avg DESC;


SELECT DISTINCT
    c.name AS company_name
FROM companies c
JOIN job_postings jp ON c.company_id = jp.company_id
WHERE 
    jp.job_health_insurance = TRUE
    AND EXTRACT(YEAR FROM jp.job_posted_date) = 2023
    AND EXTRACT(QUARTER FROM jp.job_posted_date) = 2022;


SELECT DISTINCT
    name AS company_name
FROM
    company_dim
LEFT JOIN job_postings_fact USING (company_id)
WHERE
    job_posted_date >= '2023-01-01'
    AND job_posted_date < '2024-01-01'
    AND job_health_insurance = TRUE
    AND job_title_short = 'Data Analyst';


SELECT 
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(job_id) AS job_count
FROM 
    job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY 
    month
ORDER BY 
    month;

CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'New York, NY' THEN 'Local'
        WHEN job_location = 'Anywhere' THEN 'Remote'
        ELSE 'On-Site'
    END AS local_category
FROM
    job_postings_fact
where
    job_title_short = 'Data Analyst'
GROUP BY
    local_category;


SELECT 
    job_title,
    salary_year_avg,
    -- Creating the salary buckets
    CASE 
        WHEN salary_year_avg > 120000 THEN 'High'
        WHEN salary_year_avg > 80000 THEN 'Standard'
        ELSE 'Low'
    END AS salary_category
FROM 
    job_postings
WHERE 
    job_title = 'Data Analyst' -- Filtering for specific roles
    AND salary_year_avg IS NOT NULL -- Ensuring we only see postings with data
ORDER BY 
    salary_year_avg DESC; -- Sorting from highest to lowest


SELECT
    job_title_short,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'High'
        WHEN salary_year_avg >= 60000 THEN 'Standard'
        ELSE 'Low'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;