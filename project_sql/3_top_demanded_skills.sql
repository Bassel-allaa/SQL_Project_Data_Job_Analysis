/*
Question: What are the most in-demand skills for data analysts based on job postings?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for data analysts
-Focus on all job postings
-Why? Retrieves the top 5 skills with the highest demand for data analyst positions
*/

SELECT
    skills,
    COUNT(job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim USING (job_id)
INNER JOIN skills_dim USING (skill_id)
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;