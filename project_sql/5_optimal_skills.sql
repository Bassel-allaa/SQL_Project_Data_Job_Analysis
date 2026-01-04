/*
Answer: What are the most optimal skills to leark (aka it's in high demand and high-paying skills)?
-Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
-Why? Target skills that offer job security (high demand) and financial benefits (high pay)
*/

WITH skill_demand AS (
  SELECT
    skills,
    skill_id,
    COUNT(skills_job_dim.skill_id) AS demand_count
  FROM job_postings_fact
  INNER JOIN skills_job_dim USING (job_id)
  INNER JOIN skills_dim USING (skill_id)
  WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL
  GROUP BY skill_id, skills
), avg_salary AS (
  SELECT
    skills,
    skill_id,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
  FROM job_postings_fact
  INNER JOIN skills_job_dim USING (job_id)
  INNER JOIN skills_dim USING (skill_id)
  WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL
  GROUP BY skill_id, skills
)

SELECT
  skill_demand.skill_id,
  skill_demand.skills AS skill,
  skill_demand.demand_count,
  avg_salary.average_salary
FROM skill_demand
INNER JOIN avg_salary USING (skill_id)
WHERE demand_count > 50
ORDER BY demand_count DESC, average_salary DESC
LIMIT 25;

-- Rewriting this same query more concisely without CTEs:

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.skill_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim USING (job_id)
INNER JOIN skills_dim USING (skill_id)
WHERE
  job_title_short = 'Data Analyst'
  AND job_work_from_home = True
  AND salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.skill_id) > 10
ORDER BY average_salary DESC, demand_count DESC
LIMIT 25;