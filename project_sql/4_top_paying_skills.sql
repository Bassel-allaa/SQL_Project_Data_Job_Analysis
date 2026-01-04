/*
Answer: What are the top skills based on salary for data analysts?
- Look at the average salary associated with each skill for data analyst positions
- Focus on roles with specified salaries
- Why? It reveals how different skills impact salary levels for data analysts
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim USING (job_id)
INNER JOIN skills_dim USING (skill_id)
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY skills
ORDER BY average_salary DESC
LIMIT 25;


/*
Here are the three key takeaways from the top-paying skills for data analysts:
-Big Data Scaling is the Top Earner: PySpark ($208k) is the highest-paying skill by a wide margin, signaling that the ability to process massive datasets in distributed environments is more valuable than traditional, single-machine analysis.
-The "DataOps" Shift: High rankings for tools like Bitbucket ($189k), GitLab ($154k), and Kubernetes ($132k) show that the most lucrative roles require analysts to act like software engineers, prioritizing version control, automation, and cloud infrastructure.
-Python Mastery is Non-Negotiable: The list is dominated by the Python ecosystem (Jupyter, Pandas, NumPy, and Scikit-learn), confirming that deep expertise in these libraries remains the most consistent foundation for reaching a six-figure salary.
*/
