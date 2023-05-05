create database employee;
use employee;
###3.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.
select ï»¿EMP_ID,FIRST_NAME,LAST_NAME, GENDER, DEPT
from emp_record_table;
###4.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
#●less than two
select ï»¿EMP_ID,FIRST_NAME,LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table where EMP_RATING < 2;
#●greater than four
select ï»¿EMP_ID,FIRST_NAME,LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table where EMP_RATING > 4; 
#●between two and four
select ï»¿EMP_ID,FIRST_NAME,LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table where EMP_RATING between 2 and 4; 
###6.Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
select concat_ws(' ', FIRST_NAME, LAST_NAME) as 'NAME' from
emp_record_table where dept='Finance';
###6.Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (include the President and the CEO of the organization).
select * from emp_record_table where role in ('PRESIDENT','MANAGER');
###7.Write a query to list down all the employees from the healthcare and finance domain using union. Take data from the employee record table.
select FIRST_NAME, LAST_NAME, DEPT from emp_record_table where DEPT='HEALTHCARE' 
UNION
select FIRST_NAME, LAST_NAME, DEPT from emp_record_table where DEPT='FINANCE';
### Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department
select ï»¿EMP_ID,FIRST_NAME,LAST_NAME, ROLE, DEPT, EMP_RATING, MAX(EMP_RATING) as DEPTWISE_RATING 
from emp_record_table group by DEPT order by EMP_RATING desc;
###9.Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.
select role,MAX(SALARY), MIN(SALARY) from emp_record_table group by role;
###10.Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.
select concat_ws(' ', FIRST_NAME, LAST_NAME) as FULL_NAME, EXP, RANK() over (order by EXP DESC) as EXP_ON_RANK 
from emp_record_table order by EXP desc;
###11.Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.
create view employee as select ï»¿EMP_ID, SALARY,COUNTRY from emp_record_table where SALARY > 6000;
select * from employee;
###12.Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
select * from emp_record_table where 
 SALARY in (select SALARY from emp_record_table where EXP > 10);
 ###13.Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.
 drop procedure if exists employee_1;

 delimiter //
 create procedure employee_1( in EXPERINANCE int)
 begin
 select * from emp_record_table where 
 EXP > EXPERINANCE
 order by EXP;
 end//
 delimiter ;
 call employee_1( 3 );
###14.Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.
drop function if exists job_profiles;

delimiter $$

create function job_profiles(
	EXP 	int
)
RETURNS varchar(30)
DETERMINISTIC
BEGIN

	declare v_EXP_info 	char(30);
    
	case  
		when EXP >= 0 and EXP <= 2 then set v_EXP_info = 'JUNIOR DATA SCIENTIST';
	    when EXP >= 2 and EXP <= 5 then set v_EXP_info = 'ASSOCIATE DATA SCIENTIST';
        when EXP >= 5 and EXP <= 10 then set v_EXP_info = 'SENIOR DATA SCIENTIST';
        when EXP >= 10 and EXP <= 12 then set v_EXP_info = 'LEAD DATA SCIENTIST';
        else
			set v_EXP_info = 'MANAGER';
	end case;
    return v_EXP_info;
END $$

delimiter ; 
drop procedure if exists job_profile_assigned;

delimiter $$

create procedure job_profile_assigned()
BEGIN
	select EXP, 
		job_profiles(EXP) as standard
	from data_science_team
	order by 2;
END $$

delimiter ;
call job_profile_assigned;
###15.Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
alter table emp_record_table RENAME column EMP_ID to EMP_ID;
select* from emp_record_table;
create index index_name on emp_record_table(EXP);
show indexes from emp_record_table;
select * from emp_record_table where FIRST_NAME = 'Eric';
###16.Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
select *, ((0.05*SALARY)*EMP_RATING) as bonus from emp_record_table order by ((0.05*SALARY)*EMP_RATING) desc;
###17.Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.
select COUNTRY, CONTINENT, AVG(SALARY) as avgsalary from emp_record_table
group by COUNTRY, CONTINENT
order by AVG(SALARY) desc;


 
