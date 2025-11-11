use myprojet;
--  DATA CLEANING 
select*
from hr;

ALTER TABLE hr
CHANGE COLUMN `ï»¿id` `em_id` VARCHAR(20) NULL;

DESCRIBE  hr;
select birthdate from hr;

UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%d-%m-%y'), '%Y-%m-%d')
    ELSE NULL
END;
alter table hr
modify column birthdate date; 


select hire_date from hr;
UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%d-%m-%y'), '%Y-%m-%d')
    ELSE NULL
END;
alter table hr
modify column hire_date date; 


 select termdate from hr; 
 update hr
 set termdate=date (str_to_date(termdate,'%Y-%m-%d-%H:%i:%s UTC'))
 where termdate is not null and termdate!='';
 
UPDATE hr
SET termdate = NULL
WHERE termdate = '' OR termdate IS NULL;

alter table hr add column age int;
update hr
set age =timestampdiff(year,birthdate,CURDATE());

select min(age)as youngest,
max(age) as holdest
from hr ;

select count(age)
from hr
where age<0;

-- DATA ANALYSE
select count(em_id) as numberByGender,gender
from hr
where age>18 and termdate is null
GROUP BY  gender;




select race ,count(*) as numberOfEmploy
from hr 
where age>18 and termdate is null
group by race
order by count(*) desc;


SELECT 
min(age)as youngest
,max(age)as oldest
from hr
where age>18 and termdate is null;


SELECT 
  CASE
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 60 THEN '55-60'
    ELSE '60+'
  END AS age_group,
  COUNT(*) AS count
FROM hr
WHERE age > 18 AND termdate IS NULL
GROUP BY age_group
ORDER BY age_group;


SELECT 
  CASE
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 60 THEN '55-60'
    ELSE '60+'
  END AS age_group,
  COUNT(*) AS count,
  gender 
FROM hr
WHERE age > 18 AND termdate IS NULL
GROUP BY age_group,gender
ORDER BY age_group,gender;


select location,count(*)
from hr
WHERE age > 18 AND termdate IS NULL
group by  location;

select
avg(datediff(termdate,hire_date))/365 as avg_length_emp
from hr
where termdate<=curdate() and termdate is not null and age>18;


select department ,gender,count(*) as count
from hr 
WHERE age > 18 AND termdate IS NULL
group by department ,gender
order by department;


select jobtitle,count(*)as count
from hr
WHERE age > 18 AND termdate IS NULL
group by jobtitle
order by jobtitle desc;


select location_state,count(*)as count
from hr
WHERE age > 18 AND termdate IS NULL
group by location_state
order by count desc;

SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS net_change,
    ROUND(((COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END)) / COUNT(*) * 100),2) AS net_change_percent
FROM 
    hr
WHERE age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;











