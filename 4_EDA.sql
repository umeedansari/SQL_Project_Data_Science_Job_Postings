/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT  
    skills,
    round(avg(salary_year_avg)) as avg_sal
FROM 
    job_postings_fact as job_fact
INNER JOIN 
    skills_job_dim as job_dim
ON 
    job_fact.job_id=job_dim.job_id
INNER JOIN
     skills_dim as skill_tab
on
     job_dim.skill_id=skill_tab.skill_id
WHERE
    job_title_short='Data Analyst'
    AND
    salary_year_avg is not NULL
    AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_sal desc



