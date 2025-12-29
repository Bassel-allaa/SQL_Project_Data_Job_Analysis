/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities in the data analysis field for remote work seekers.
*/

SELECT
    job_id,
    job_title,
    job_location,
    salary_year_avg,
    job_posted_date,
    job_schedule_type,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim USING (company_id)
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;