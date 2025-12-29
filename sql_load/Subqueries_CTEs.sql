SELECT
    name AS company_name,
    company_id
FROM
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
)






WITH company_job_counts AS (
SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id

)
SELECT 
    company_dim.name AS company_name, 
    company_job_counts.total_jobs
FROM
    company_dim
LEFT JOIN 
    company_job_counts USING (company_id)
ORDER BY
    total_jobs DESC







SELECT
    skills_dim.skills AS skill_name,
    top_skills.skill_count
FROM (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        skill_count DESC
    LIMIT 5
) AS top_skills
JOIN skills_dim USING (skill_id);






WITH company_job_counts AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    from
        job_postings_fact
    GROUP BY
        company_id
)
SELECT 
    company_dim.name AS company_name, 
    company_job_counts.total_jobs,
    CASE
        WHEN company_job_counts.total_jobs > 100 THEN 'Large'
        WHEN company_job_counts.total_jobs BETWEEN 51 AND 100 THEN 'Medium'
        ELSE 'Small'
    END AS company_size
FROM
    company_dim
LEFT JOIN 
    company_job_counts USING (company_id)







WITH remote_job_skills AS (
    SELECT 
        skills_job_dim.skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim
    INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE 
        job_postings_fact.job_work_from_home = TRUE 
    GROUP BY 
        skills_job_dim.skill_id
)

SELECT 
    remote_job_skills.skill_id,
    skills_dim.skills AS skill_name,
    remote_job_skills.skill_count
FROM 
    remote_job_skills
INNER JOIN skills_dim ON remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5






WITH remote_job_skills AS (
SELECT
    skill_id,
    COUNT(*) AS skill_count
from
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact USING (job_id)
WHERE
    job_postings_fact.job_work_from_home = TRUE AND
    job_title_short LIKE 'Data Analyst%'
GROUP BY
    skill_id
)
SELECT
    skills_dim.skills AS skill_name,
    remote_job_skills.skill_count
FROM
    remote_job_skills
INNER JOIN skills_dim USING (skill_id)
ORDER BY
    remote_job_skills.skill_count DESC
LIMIT 5;