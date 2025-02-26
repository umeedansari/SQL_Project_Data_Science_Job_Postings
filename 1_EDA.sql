/* Question: What are the top-paying data analyst jobs? 
-Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts,
	offering insights into employment options and location flexibility. 
*/
SELECT 
    job_title,
    comp.name,
    CONCAT('$', ROUND(AVG(salary_year_avg))) AS avg_salary
FROM
    job_postings_fact AS fact
LEFT JOIN 
    company_dim AS comp ON comp.company_id = fact.company_id
WHERE
    job_title_short LIKE '%Data Analyst%'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = 
GROUP BY
    job_title, comp.name
ORDER BY 
    avg_salary DESC
LIMIT 
    10;



--Other important findings
--Which job titles have the highest number of postings, and how do they compare in demand?
select 
	job_title_short,
	count(*) job_count
from	
	job_postings_fact
group by	
	job_title_short
order by
	job_count desc ;



--Determine the number of remote versus non-remote Data Analyst job postings.
SELECT 
	job_work_from_home ,
		count(*) as Remote_count
from 
	job_postings_fact 
WHERE
	job_title_short = 'Data Analyst'
group by 
	job_work_from_home ;



--What are the top 10 locations with the highest number of Data Analyst job postings?
select 
	job_location,
	count(*) as location_count
from
	job_postings_fact
where 
	job_location <> 'Anywhere'
	and 
	job_title_short = 'Data Analyst'
group by
	job_location
order by 
	location_count desc
limit 
	10 ;



--Identify the top 10 companies hiring Data Analysts based on job posting counts.
SELECT 
	comp.name,
	count(job_title_short) as job_count
from 
	job_postings_fact as job_fact 
left join 
	company_dim as comp 
on 
	job_fact.company_id=comp.company_id
WHERE
	job_title_short = 'Data Analyst'
group by 
	comp.name
ORDER by
	job_count desc
LIMIT 
	10 ;


