/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_roles as
	(	SELECT  
    		job_id,
    		job_title,
    		job_location,
    		job_schedule_type,
    		salary_year_avg,
    		job_posted_date,
    		comp.name
		FROM 
			job_postings_fact as job_fact
		left JOIN 
			company_dim as comp
		on 
			job_fact.company_id=comp.company_id
		WHERE 
    		job_title_short='Data Analyst'
		AND 
    		job_location = 'Anywhere'
    	AND
    		salary_year_avg is not NULL
		ORDER BY 
			salary_year_avg desc
		limit 10 ;
	)
SELECT 
    top.*,
    skills 
FROM 
	top_paying_roles as top
INNER JOIN 
	skills_job_dim as job_dim 
on 
	top.job_id=job_dim.job_id
INNER JOIN 
	skills_dim as skill_tab
on 
	job_dim.skill_id=skill_tab.skill_id
ORDER BY
     salary_year_avg DESC



