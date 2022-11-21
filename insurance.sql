
-- CAR INSURANCE DATA ANALYSIS --


use project;

-- Viewing all the data --

select * from insurance;



-- finding the average credit score of male & female together --

select gender,avg(credit_score)
from insurance
group by gender;



--- finding the count of female &  male who took the claim where outcome=1 --

select gender, count(id)
from insurance 
where outcome=1
group by gender;




-- finding the count of different income class who took the claim where outcome=1 --

select income, count(id)
from insurance 
where outcome=1
group by income;



--- finding the count of different race who took the claim where outcome=1 ---

select race, count(id)
from insurance 
where outcome=1
group by race;



--- finding the count of different vehicle type who took the claim where outcome=1 ---

select vehicle_type, count(id)
from insurance 
where outcome=1
group by vehicle_type;



-- checking whether the the people with high credit score are getting their claim


select gender,CREDIT_SCORE,
case
when credit_score > 0.8 and outcome = 1 then 'yes'
else 'no'
end as claim_status
from insurance
order by CREDIT_SCORE DESC;



-- COUNTING ON THE BASIS OF GENDER WHERE CREDIT SCORE>0.8 & OUTCOME=1 --


with CTE_insurance as
(
select gender,
case
when credit_score > 0.8 and outcome = 1 then 'yes'
else 'no'
end as claim_status
from insurance
)
SELECT GENDER,COUNT(*) FROM CTE_INSURANCE
where claim_status='yes'
GROUP BY GENDER;



--- trying to find the relationship between past accidents and outcome ---



select outcome,past_accidents,count(id)
from insurance
WHERE OUTCOME=1
group by outcome,past_accidents
order by past_accidents
;


--- Ranking the average  credit score with respect to gender in each income class--
-- to get in each gender which income class have high credit score --

with CTE_insurance as
(select gender,income,outcome,avg(credit_score) as avgscore from insurance
  where outcome=1
  group by gender,income
)
select gender,avgscore,income,outcome, dense_rank()over (partition by gender order by avgscore desc ) as r
 from CTE_insurance
;



--- Getting view of education and duis of past accidents and speed violations ---


select education,duis,sum(past_accidents) as t,sum(speeding_violations) as s from insurance
 where outcome=1
 
group by education,duis
order by education;
 ;



--- Ranking by average credit score on education and income class , to get for each education group what is the rank for income class based on credit score---

with CTE_insurance as
(select education,income,avg(credit_score) as c from insurance
 where outcome=1
group by education,income

)
select education,c,income,dense_rank() over (partition by education order by c desc)
 from CTE_insurance
;



--- Gettting the count for each duis category where outcome is 1 ---


select duis,count(id) as n_claim
from insurance
where outcome=1
group by duis
;



--- Gettting the count for each duis category where outcome is 0 ---
select duis,count(id) as n_claim
from insurance
where outcome=0
group by duis
;



--- Gettting the count for each age  category where outcome is 1 ---

select age,count(id) as n_claim
from insurance
where outcome=1
group by age
order by n_claim desc
;



--- Gettting the count for each vehicle ownership category where outcome is 1 ---

select vehicle_ownership,sum(past_accidents) as n_claim
from insurance
where outcome=1
group by vehicle_ownership
order by n_claim desc
;



--- Checking whether married or unmarried people have more past accidents ---

select married,sum(past_accidents) as n_claim
from insurance
where outcome=1
group by married
order by n_claim desc
;



--- average credit score age and race wise ---
select age,race,avg(credit_score)
from insurance
group by age,race
order by age;



---  ---
select age,vehicle_ownership,count(id)
from insurance
group by age,vehicle_ownership
order by age;



--- count of vehicles in each year for each age group ---

select age,vehicle_year,count(id)
from insurance
group by age,vehicle_year
order by age;



--- Average credit score for people with different education and race ---

select race,education,avg(credit_score)
from insurance
group by race,education
order by race;



--- Average credit score for each race duis wise---
select race,duis,avg(credit_score)
from insurance
group by race,duis
order by race;

--- total Mileage for each each income category---
select income,sum(annual_mileage) as total_mileage
from insurance
group by income
order by total_mileage desc;



--- total mileage for each driving experience category ---
select driving_experience,sum(annual_mileage) as total_mileage
from insurance
group by driving_experience
order by total_mileage desc;



--- Total of pass accidents for each vehicle type---

select vehicle_type,sum(past_accidents)
from insurance
group by vehicle_type;



--- total of speeding violations for each race ---

select race,sum(speeding_violations)
from insurance
group by race;



--- Total of speeding violations having children and not having children ---

select children,sum(speeding_violations)
from insurance
group by children;



--- percentage of annual mileage by age ---



select age,(annual_mileage/sum(annual_mileage))*100
from insurance
group by age;

select age,m,m*100/(select sum(annual_mileage)  from insurance) as percentage from
(select age,sum(annual_mileage) as m
from insurance
group by age

) as p
order by percentage desc
;



-- percentage of speeding violations by driving experience---

select driving_experience,s*100/(select sum(speeding_violations)  from insurance) as percentage from
(select driving_experience,sum(speeding_violations) as s
from insurance
group by driving_experience

) as p
order by percentage desc
;


-----------------------------X-------------------------------X--------------------------------------X------------------------------------X--------------------------------X---------------------------------------


