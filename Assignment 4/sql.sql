-- 1.Select employee details  of dept number 10 or 30 
SELECT * FROM new_schema1.`emp table` WHERE DeptNo IN (10,30);

-- 2.Write a query to fetch all the dept details with more than 1 Employee.
SELECT * FROM new_schema1.`emp table` WHERE DeptNo > 1;

-- 3.Write a query to fetch employee details whose name starts with the letter “S”
SELECT * FROM new_schema1.`emp table` WHERE Ename Like 'S%';

-- 4.Select Emp Details Whose experience is more than 2 years
SELECT * FROM new_schema1.`emp table` WHERE DATEDIFF(NOW(), Hire_Date) > 730;

-- 5.Write a SELECT statement to replace the char “a” with “#” in Employee Name ( Ex:  Sachin as S#chin)
SELECT REPLACE(Ename, 'a', '#') FROM new_schema1.`emp table`;

-- 6.Write a query to fetch employee name and his/her manager name.
SELECT E.Ename AS EmployeeName, M.Ename AS ManagerName
FROM new_schema1.`emp table` AS E
LEFT JOIN new_schema1.`emp table`AS M 
ON E.Mgr = M.EmpNo;

-- 7.Fetch Dept Name , Total Salary of the Dept
SELECT D.DeptNo, D.Dname, sum(E.Sal) 
FROM new_schema1.`dept table` D  LEFT JOIN new_schema1.`emp table` E
ON D.DeptNo=E.DeptNo
GROUP BY D.DeptNo;

-- 8.Write a query to fetch ALL the  employee details along with department name, department location, 
-- irrespective of employee existance in the department.
SELECT * FROM new_schema1.`dept table` D , new_schema1.`emp table` E WHERE D.DeptNo=E.DeptNo;

-- 9.Write an update statement to increase the employee salary by 10 %
SET SQL_SAFE_UPDATES = 0;
UPDATE new_schema1.`emp table` SET Sal = Sal*1.1;
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM new_schema1.`emp table`;

-- 10.Write a statement to delete employees belong to Chennai location.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM new_schema1.`emp table`WHERE DeptNo IS NULL
OR DeptNo IN (SELECT DeptNo FROM new_schema1.`dept table` WHERE Loc = 'Chennai');
SET SQL_SAFE_UPDATES = 1; 
SELECT *FROM new_schema1.`emp table` AS E LEFT JOIN new_schema1.`dept table` AS D ON E.DeptNo = D.DeptNo;

-- 11. Get Employee Name and gross salary (sal + comission) .
SELECT Ename AS EmployeeName, Sal + IFNULL(Commission, 0) AS GrossSalary
FROM new_schema1.`emp table`;

-- 12.Increase the data length of the column Ename of Emp table from  100 to 250 using ALTER statement
ALTER TABLE new_schema1.`emp table` MODIFY Ename varchar(250);

-- 13.Write query to get current datetime
SELECT CURRENT_TIMESTAMP();

-- 14.Write a statement to create STUDENT table, with related 5 columns
CREATE Table Student_Table( Student_Name varchar(20), Roll_no varchar(10), DOJ int, DOB date, Loc varchar(20));
SHOW columns FROM Student_Table;

-- 15.Write a query to fetch number of employees in who is getting salary more than 10000
SELECT COUNT(*) FROM new_schema1.`emp table` WHERE Sal>10000;

-- 16.Write a query to fetch minimum salary, maximum salary and average salary from emp table.
SELECT min(Sal), max(Sal), avg(Sal) FROM new_schema1.`emp table`;

-- 17.Write a query to fetch number of employees in each location
SELECT Loc ,COUNT(*)AS EmployeeCount
FROM new_schema1.`dept table`D LEFT JOIN new_schema1.`emp table`E ON D.DeptNo = E.DeptNo 
GROUP BY Loc;

-- 18.Write a query to display emplyee names in descending order
SELECT Ename FROM new_schema1.`emp table` ORDER BY Ename DESC;

-- 19.Write a statement to create a new table(EMP_BKP) from the existing EMP table 
CREATE TABLE Emp_BKP AS SELECT * FROM new_schema1.`emp table`;

-- 20.Write a query to fetch first 3 characters from employee name appended with salary.
SELECT CONCAT(LEFT(Ename, 3), ' ', Sal) AS Name_Salary FROM new_schema1.`emp table`;

-- 21.Get the details of the employees whose name starts with S
SELECT * FROM new_schema1.`emp table` WHERE Ename Like 'S%';

-- 22.Get the details of the employees who works in Bangalore location
SELECT * FROM new_schema1.`dept table`D LEFT JOIN new_schema1.`emp table`E 
ON D.DeptNo = E.DeptNo
WHERE Loc='Bangalore';

-- 23. Write the query to get the employee details whose name started within  any letter between  A and K
SELECT * FROM new_schema1.`emp table` WHERE Ename LIKE '[A-K]%';

-- 24.Write a query in SQL to display the employees whose manager name is Stefen 
SELECT E.Ename AS EmployeeName FROM new_schema1.`emp table` E 
LEFT JOIN new_schema1.`emp table` M ON E.Mgr = M.EmpNo
WHERE M.Ename = 'Stefen';

-- 25. Write a query in SQL to list the name of the manager who is having maximum number
--  of employees working under him.
SELECT M.Ename AS ManagerName, COUNT(*) AS EmployeeCount
FROM new_schema1.`emp table` AS E
LEFT JOIN new_schema1.`emp table` AS M ON E.Mgr = M.EmpNo
GROUP BY M.Ename;

-- 26. Write a query to display the employee details, department details and the manager details of the 
-- employee who has second highest salary
SELECT E.EmpNo AS EmployeeID, E.Ename AS EmployeeName, E.Sal AS EmployeeSalary,D.DeptNo AS DepartmentID,
D.Dname AS DepartmentName, D.Loc AS DepartmentLocation, M.Ename AS ManagerName
FROM new_schema1.`emp table` AS E
JOIN new_schema1.`dept table` AS D ON E.DeptNo = D.DeptNo
LEFT JOIN new_schema1.`emp table` AS M ON E.Mgr = M.EmpNo
WHERE E.Sal = (
        SELECT MAX(Sal)
        FROM new_schema1.`emp table`
        WHERE Sal NOT IN (
            SELECT MAX(Sal)
            FROM new_schema1.`emp table`
        )
    );
    
-- 27.Write a query to list all details of all the managers
SELECT DISTINCT E.* FROM new_schema1.`emp table` AS E
INNER JOIN new_schema1.`emp table` AS M ON E.EmpNo = M.mgr
WHERE M.mgr IS NOT NULL;

-- 28.Write a query to list the details and total experience of all the managers
SELECT M.EmpNo ,M.Ename, TIMESTAMPDIFF(YEAR, M.Hire_Date,CURDATE()) AS TotalExperience
FROM new_schema1.`emp table` AS M
JOIN new_schema1.`emp table` AS E ON M.EmpNo = E.Mgr
GROUP BY M.EmpNo, M.Ename;

-- 29.Write a query to list the employees who is manager and  takes commission less than 1000 and works in Delhi
SELECT E.* FROM new_schema1.`emp table` AS E
JOIN new_schema1.`dept table` AS D ON E.DeptNo = D.DeptNo
WHERE E.Commission < 1000 AND D.Loc = 'Delhi';

-- 30.Write a query to display the details of employees who are senior to Martin 
SELECT *  FROM new_schema1.`emp table`
WHERE Hire_Date < ( SELECT Hire_Date FROM new_schema1.`emp table`WHERE Ename = 'Martin');

