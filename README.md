# Pewlett-Hackard Analysis

## Overview of the Analysis
The company Pewlett-Hackard is forecasting a "silver tsunamis" as many current employees are reaching retirement age. Bobby and I are creating a report for the managers at Pewlett-Hackard to determine the number of retiring employees per title and to help identify employees who are eligible to participate in a mentorship program. For our analysis we took a deep dive into employees who were born between 1952-1955 are considered retirement ready and employees who were born in 1965 would be eligible for mentorship. 

## Results:

* There are 133,776 employees in this "Retirement Titles" table who had birthdates in years 1952-1955.
* This table contains duplicates when the employee got a promotion or job transfer. 
#### Retirement Titles Table
<img width="532" alt="retirement_titles" src="https://user-images.githubusercontent.com/111904266/203078931-19f7b7e2-eab5-4eaf-bdb3-2ce949f801eb.png">


* This "Unique Titles" table was filtered from "Retirement Titles" table to remove the duplicates of promotions or job transfers. 
* This table is also filtered to current employees.
* There are 72,458 current employees ready to retire!!
#### Unique Titles Table
<img width="391" alt="unique_titles" src="https://user-images.githubusercontent.com/111904266/203078688-9e0ad2b8-93fe-46a7-ada8-1fb6bf1c36a3.png">


* Here is a breakdown of retire-ready employees by department.
<img width="275" alt="retiring_titles" src="https://user-images.githubusercontent.com/111904266/203089820-9b20b31e-0bf8-46e7-bac0-9dfe37829cb2.png">


* Here is a breakdown of mentorship-ready employees by department.
<img width="266" alt="mentor_titles" src="https://user-images.githubusercontent.com/111904266/203091712-c4a3e113-e628-42cd-a98c-3be10853694a.png">


* There are 1,549 eligible current employees ready to get mentored.
* These employees were filtered based on having a birthdate in year 1965.
#### Mentorship Eligibility table
<img width="585" alt="mentorship_eligibilty" src="https://user-images.githubusercontent.com/111904266/203080584-d27763c3-40cd-4c60-939d-26aed3df292a.png">


## Summary: 
* How many roles will need to be filled as the "silver tsunami" begins to make an impact?
There are 72,548 employees at PH who are starting to consider retirement. 

* Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
There is plenty of retirement-ready employees to mentor the next generation in each department.

### Additional Queries
 
 With only 1,549 eligible employees for mentorship, I am curious how many we would get if we widen the range of eligible employees to include birthdate year 1964-1966
 * Three-year birthdate range 1964-1966 output is 19,905 employees
 * Five-year birthdate range of 1963-1967 has 38,401 eligible employees... this is a bit better but still nowhere close to replacing 72,000 employees with industry knowledge

<img width="591" alt="five_yr_mentorship_eligibily" src="https://user-images.githubusercontent.com/111904266/203083849-9968b0cb-0ece-4a82-9093-1a91c2011db6.png">

 I was curious about the average length of employment at PH and after working with the data I quickly realized I needed to perform this query on former employees because all current employees have a "to_date" of year 9999 which would skew the data. (as of now I don not know how to import today's date... more to learn).

#### Past Employee Average duration of employment at PH
 <img width="578" alt="non_ee_durration" src="https://user-images.githubusercontent.com/111904266/203092950-0c2b8d34-31c5-4d40-bc15-cdd5eb589c2f.png">
 
 #### Average Duration of Employment
 <img width="299" alt="avg_durration_non_current_ee" src="https://user-images.githubusercontent.com/111904266/203093620-2691cb68-9e94-427b-a3b2-798902c3b146.png">
* This equates to an average of 7.22 years working at PH.
* *NOTE* this does not include the current employees.
* I hope the mentored employees stick around. 
 
 
