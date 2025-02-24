/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

-- Identifies skills in high demand for Data Analyst roles


WITH demand_jobs AS 
(
    SELECT 
        skill_tab.skill_id,
        skill_tab.skills,
        COUNT(skill_tab.skill_id) AS demand_count
    FROM    
        job_postings_fact AS job_fact
    INNER JOIN  
        skills_job_dim AS job_dim 
    ON 
        job_fact.job_id = job_dim.job_id
    INNER JOIN
        skills_dim AS skill_tab
    ON 
        job_dim.skill_id = skill_tab.skill_id
    WHERE 
        job_fact.job_title_short = 'Data Analyst'
        AND 
        job_fact.job_work_from_home = TRUE
    GROUP BY
        skill_tab.skill_id, skill_tab.skills
    ORDER BY   
        demand_count DESC
), avg_salary AS
( 
    SELECT  
        skill_tab.skill_id,
        ROUND(AVG(job_fact.salary_year_avg)) AS avg_sal
    FROM 
        job_postings_fact AS job_fact
    INNER JOIN 
        skills_job_dim AS job_dim
    ON 
        job_fact.job_id = job_dim.job_id
    INNER JOIN
        skills_dim AS skill_tab
    ON
        job_dim.skill_id = skill_tab.skill_id
    WHERE
        job_fact.job_title_short = 'Data Analyst'
        AND
        job_fact.salary_year_avg IS NOT NULL
        AND
        job_fact.job_work_from_home = TRUE
    GROUP BY
        skill_tab.skill_id
    ORDER BY
        avg_sal DESC
) 

SELECT
    demand_jobs.skills,
    demand_jobs.demand_count,
    avg_salary.avg_sal
FROM 
    demand_jobs
INNER JOIN  
    avg_salary
ON  
    avg_salary.skill_id = demand_jobs.skill_id
ORDER BY 
    demand_jobs.demand_count DESC;

