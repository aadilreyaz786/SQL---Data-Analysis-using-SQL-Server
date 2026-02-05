SELECT * FROM Employees
SELECT * FROM Departments

---2nd Highest Salary----
SELECT MAX(Salary) FROM Employees 
WHERE Salary < (SELECT MAX(Salary) FROM Employees)

----nth highesht Salary using Subquery-----
SELECT MIN(Salary) as Third_Highest_Salary
FROM (SELECT TOP 3 Salary FROM Employees ORDER BY Salary Desc)

----nth highesht Salary using Window Function -----
select * from
(select *, DENSE_RANK() OVER(order by Salary Desc) as Salary_Rank
from Employees) as t
where Salary_Rank = 3

---Employees whose salary greather the avg Salary----
SELECT * FROM Employees
WHERE Salary > (SELECT AVG(Salary) as AVG_SALARY FROM Employees)

---Date Functions----
Select GETDATE()
SELECT CURRENT_DATE
SELECT DATEDIFF (DAY, '2025-12-06',GETDATE())

---Let's add duplicate values to Employees table----
insert into Employees values (10,'Aadil', 'Reyaz',2,58000,'2025-05-10'),
                             (11,'Eve', 'Davis',3,90000,'2021-02-25')

-------Find duplicate records------
Select DepartmentID, FirstName, LastName, Salary, count(*) 
FROM Employees 
GROUP BY DepartmentID, FirstName, LastName, Salary
Having Count(*) >1

-------Find duplicate records using Window function------
Select * FROM
(SELECT DepartmentID, FirstName, LastName, Salary, 
count(*) OVER (PARTITION BY DepartmentID, FirstName, LastName, Salary) as Duplicate_Count
FROM Employees) AS t
WHERE Duplicate_Count > 1

----Running total of salaries by department-----
select * from 
(select e.firstname, e.lastname, d.departmentname, e.salary, sum(salary) over (partition by departmentname order by salary desc) as Running_Total
from employees as e
inner join departments as d
on e.departmentid = d.departmentid) t

---Find employees who joined in 2020 ----
SELECT * FROM Employees
WHERE DATEPART(Year, DateHired) = '2020'

------------OR--------------
SELECT * FROM Employees
WHERE YEAR(DateHired) = '2020'

-----Find Employees whose Name Starts with A----
SELECT * FROM Employees
WHERE FirstName LIKE 'A%'

-----Find Employees whose Name ends with E----
SELECT * FROM Employees
WHERE FirstName LIKE '%E'

SELECT * FROM Employees
WHERE FirstName LIKE '_A%'

-----Count of Employee in each Dept/ Dept with Highest number of employees-----
Select ---TOP 1 
DepartmentID, Count(*) as NumberOfEmployees
FROM Employees
group by DepartmentID
order by NumberOfEmployees Desc

-------Higesht Salary in each Department-----
SELECT DepartmentID, EmployeeID, Salary
FROM Employees as e
WHERE Salary = (SELECT MAX(SALARY) FROM Employees WHERE DepartmentID = e.DepartmentID)

-------Higesht Salary in each Department using Window function-----
SELECT * FROM
(SELECT *, DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary Desc) as Salary_Rank
FROM Employees) as t
WHERE Salary_Rank = 1

SELECT DISTINCT(DepartmentName) FROM Departments

---Find employees whose tenure is more than 5 years----
SELECT * FROM Employees
WHERE DATEDIFF(YEAR,Datehired,GETDATE()) >=5

---------------OR----------------
SELECT * FROM Employees
WHERE DATEDIFF(YEAR,Datehired,CURRENT_DATE) >=5













