use heart_disease_analysis;

#count the data
select count(*) from heart_disease_analysis.heart_disease;

#select command
select * from heart_disease_analysis.heart_disease;

#Analysis the data
#1 Total number of patients sql

SELECT COUNT(*) AS total_patients
FROM heart_disease_analysis.heart_disease;

#2 How many patients have heart disease and how many do not?
with heart_attack_person as
(
	SELECT 
		heart_disease,
        count(*) as heart_disease_person
	from heart_disease_analysis.heart_disease
    where Heart_Disease=1
)
select * from heart_attack_person;

WITH heart_non_attack_person AS (
    SELECT 
        heart_disease,
        COUNT(*) AS heart_disease_person
    FROM heart_disease_analysis.heart_disease
    WHERE heart_disease = 0
)
SELECT *
FROM heart_non_attack_person;

# 3 Which gender has more heart disease cases?
	select
		Gender,
        sum(Heart_disease) as total_count_based_on_gender
	from heart_disease_analysis.heart_disease
    group by Gender;
    
# 4 What is the average age of patients with heart disease vs without heart disease?

	select
		Age,
        sum(Heart_Disease)
	from heart_disease_analysis.heart_disease
    group by Age;
    
# 5 What is the maximum and minimum cholesterol level recorded in the dataset?
select
    max(Cholesterol_Total)  as maximum_chloesterol,
    min(Cholesterol_Total)  as minimum_chloesterol
from heart_disease_analysis.heart_disease;
	
#6 Do patients with higher cholesterol levels have more heart disease cases?

SELECT
	CASE
		WHEN Cholesterol_Total<200 THEN 'NORMAL(<200)'
		WHEN Cholesterol_Total BETWEEN 200 AND 239 THEN 'Borderline (200-239)'
		WHEN Cholesterol_Total >= 240 THEN 'High (>=240)'
	END AS chol_range,
    count(*) as cholestrol_total_count_based_on_range,
    sum(Heart_Disease)
FROM heart_disease_analysis.heart_disease
GROUP BY chol_range
ORDER BY chol_range;

# 7 How many patients with fasting blood sugar > 120 mg/dl have heart disease?
SELECT
	CASE
		WHEN Blood_Sugar_Fasting>120 THEN 'High FBS (>120)'
		ELSE 'NORMAL'
    END AS BLOOD_SUGAR_RANGE,
    COUNT(*) AS BLOOD_SUGAR_RANGE,
	sum(Heart_Disease) as heart_disease_based_on_blood_sugar
from heart_disease_analysis.heart_disease
group by BLOOD_SUGAR_RANGE;

#8 Does exercise-induced angina (exang) increase the chance of heart disease?
select
	Physical_Activity,
    Stress_Level,
    Diet,
    sum(Heart_Disease)
FROM heart_disease_analysis.heart_disease
group by Physical_Activity,Stress_Level,Diet
order by Physical_Activity,Stress_Level,Diet;
    
#9 Which age group (20–30, 31–40, 41–50, 51–60, 60+) has the highest heart disease cases?
select
	CASE
		WHEN Age between 20 and 30 THEN 'HEART DISEASE COUNT 20–30'
        WHEN Age between 31 and 40 THEN 'HEART DISEASE COUNT 31–40'
        WHEN Age between 41 and 50 THEN 'HEART DISEASE COUNT 41–50'
        WHEN Age between 51 and 60 THEN 'HEART DISEASE COUNT 51–60'
        WHEN Age>60 THEN 'HEART DISEASE COUNT 60'
	END AS age_wise_heart_disease,
	count(*) as age_wise_heart_disease_count,
    sum(Heart_Disease) as age_wise_heart_disease_sum
FROM heart_disease_analysis.heart_disease
GROUP BY age_wise_heart_disease
ORDER BY age_wise_heart_disease;

# 10 Among men and women, who has a higher percentage of heart disease cases?
SELECT
	Gender,
    sum(Heart_Disease)
from heart_disease_analysis.heart_disease
GROUP BY Gender;

# 11 Does low physical activity correlate more strongly with high 
#cholesterol or with high blood pressure among heart disease patients?

select
Physical_Activity,
Systolic_Bp,
Diastolic_Bp,
sum(heart_disease) as heart_disease_based_range
from heart_disease_analysis.heart_disease
GROUP BY Physical_Activity,Systolic_Bp,Diastolic_Bp
ORDER BY Physical_Activity,Systolic_Bp,Diastolic_Bp;

