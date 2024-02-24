-- 필수과제
-- 데이터 검증의 이슈를 직접 확인해서 이 데이터를 join 한 것이 맞는지 틀린지 확인하기

select * from classicmodels.employees;
select * from classicmodels.offices;

## Checking officeCode!
select count(distinct(officeCode)) from classicmodels.employees;
select count(officeCode) from classicmodels.offices;

select count(officeCode) from classicmodels.employees
	group by officeCode
	having count(officeCode)>1; 

## employeeNumber 중복 체크!    
select count(employeeNumber) from classicmodels.employees
	group by employeeNumber
	having count(employeeNumber)>1;

## join
select * from classicmodels.employees as e
	left outer join classicmodels.offices as o 
    on e.officeCode = o.officeCode;