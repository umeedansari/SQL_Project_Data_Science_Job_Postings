/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skill_tab.skills,
    count(job_fact.job_id) as role_count
FROM    
     job_postings_fact  as job_fact
INNER JOIN  
    skills_job_dim as job_dim 
ON
    job_fact.job_id=job_dim.job_id
INNER JOIN
     skills_dim as skill_tab
ON
    job_dim.skill_id=skill_tab.skill_id
WHERE 
    job_fact.job_title_short = 'Data Analyst'
    AND 
    job_fact.job_work_from_home = TRUE
GROUP BY 
    skill_tab.skills
ORDER BY   
    role_count desc
LIMIT 5 ;

