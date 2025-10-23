SELECT * FROM parks_and_recreation.employee_demographics;
#SELECT: it does what you think it does
#SELECT: you can use * to make it select every row but you can also 
#SELECT: choose rows by going SELECT rowNAME, rowNAME FROM databaseNAME

#SELECT EXAMPLE: SELECT first_name, Last_name, gender FROM parks_and_recreation.employee_demographics;
# ^^ Show me only the first name, last name, and gender columns from the empolyee demographics table in the parks and rec database

#WHERE: essentially a filter
#WHERE: return smth WHERE is true

#WHERE EXAMPLE:
 
# SELECT * FROM parks_and_recreation.employee_salary
# WHERE first_name = 'Leslie'
# ;
# ^^Show me all the columns from the employee salary table where the first name equals leslie
 
# Comparison functions in SQL: =, >, <, >=, <=
# Should be very self explainatory
# != is NOT Equal to
# ! is the not function

#DATE FORMAT: YYYY-MM-DD

-- Logical Operators--

#AND: its an and function what do you need to know
#OR: its an or function you know this
#NOT: I wonder what this one does????

#You can use parenthesis to section out logical sections (much like other coding languages)

#LIKE statement: Patterns, not exact matches like eq
#LIKE: does it start with a certain group of letters?
#LIKE: first_name LIKE 'JER%'
# % means the letters before/after the percent doesnt really matter
# _ means that it has a certain amount of characters in it
# first_name LIKE 'A___' means it has to have an A and amount of underscores in it
# is exact without a percentage to make it varied

-- Group By -- 
#Columns must be the same to group by column
#unless it is aggregate then it can be grouped seperately
#Aggregate means that it has a function being attatched to it, AVG(), MIN(), MAX(), ETC


#EXAMPLE:
# SELECT gender, AVG(age) 
# FROM parks_and_recreation.employee_demographics
# GROUP BY gender

SELECT gender, AVG(age) 
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;
# ^^ shows the average age for each group

-- Order By --

#Sorts the data set by the ascending or descending 
#ORDER BY: ASC = ascending, DESC = descending (shocker)

#You can order by multiple things, Gender and age or other things
#ORDER BY gender, age

#You can use the 'Position' of the field instead of names for columns,
#Shiraz YOU will not be using this do NOT worry about it

-- HAVING VS WHERE --
#its to filter after GROUP BY aggregate functions
#where does not really work in that situation

-- LIMIT

#Sets a limit to amount of rows in response
#Can combine with order by to only have the top/bottom ___ in the table
# LIMIT (Starting position, how many rows after)

-- Aliasing
#very similar to variables, changes the names of the column
#AS: the function needed to make the alias

# SELECT gender, 
# AVG(age) AS (<- this as isnt actually necessary its implied if you dont use it) avg_age

#^^ now you can use avg_age as the name of the column in the same query (I dont believe it transcends quereys)

-- JOINS --
#You can join two tables (or more) together if they have a common column 
# (the data matters more than the names)

--  INNER JOIN: Return rows that are the same in the same columns and same tables
# Remember that class you took at gmu
#the inside of a venn diagram

#SELECT * FROM employee_demographics 
#INNER JOIN employee_salary
#	ON employee_demographics.employee_id = employee_salary.employee_id
#;

-- ON --

#Okay brotatochip the ON function is explaining what is the column you want to join the tables with
# You have to specify which table you want to join them too

-- ALIAS CONT --
#you can use alias to make it easier to read

#SELECT * FROM employee_demographics AS dem
#INNER JOIN employee_salary AS sal
#	ON dem.employee_id = sal.employee_id
#;

# When using joins you have to be specific which tables you want to grab ambiguous columns from


-- OUTER JOIN: There is a left outer and a right outer

#LEFT JOIN: takes things from the left table and only returns things from the right table that match
#RIGHT JOIN: the opposite is true

#IF there is something that doesnt exist in one table and you try to join it will create null

-- SELF JOIN
#Joins it to itself

# SELECT *
# FROM employee_salary emp1
# JOIN employee_salary emp2
# 	ON emp1.employee_id + 1 = emp2.employee_id
# ;


-- JOINING MULTIPLE TABLES

#SELECT *
#FROM employee_demographics AS dem
#INNER JOIN employee_salary AS sal
#	ON dem.employee_id = sal.employee_id
#INNER JOIN parks_departments pd
#	ON sal.dept_id = pd.department_id
#;

-- Unions
# Unions are very similar to joins however they are for rows instead of columns
# The union function is inheriently distinct

# If you want all the values no matter what, you will use the UNION ALL function

 #SELECT first_name, last_name
 #FROM employee_demographics
 #UNION
 #SELECT first_name, last_name,
 #FROM employee_salary;

-- String Functions

# Length() returns the length of the string in the parenthesis
# LENGTH('poop') would return the int 4

# TRIM() removes the spaces to the left and the right of the given string

# TRIM('              hi ') would return 'hi'

# UPPER() makes it uppercase
# LOWER() makes it lowercase

# LTRIM() removes spaces to the left of the word
# RTRIM() bro guess

# LEFT(string, number) returns the string given the number on the left
# LEFT("hello", 4) => Returns "hell"

# RIGHT(string, number) returns the string given the number on the right
# RIGHT("Hello", 4) => Returns "ello"

# SUBSTRING(string, start_position, length) returns a sectioned off string starting at the second number going for as long as the lenght
# SUBSTRING('HELLO', 2, 2) => Returns "EL"

# REPLACE(string, find, replace) returns the string with the find value being replaced by the replacement value
# ^^ IS CASE SENSITIVE

# LOCATE(value, string) returns the position where the value is in the string
# LOCATE('h', 'hello') => RETURNS 1

# CONCAT(column1, column2) combines the columns together in a column
# CONCAT(first_name, ' ', last_name) => RETURNS full name
# ^^ the space is necessary or it will not add it for you

-- CASE STATEMENTS

# allows you to add logic to your select statement
/*
SELECT first_name,
last_name,
age,
CASE
	WHEN age <= 30 THEN 'YOUNG'
    WHEN age BETWEEN 31 and 50 THEN 'OLD'
    WHEN age >= 50 then 'ON DEATHS DOOR'
END AS Age_bracket
FROM employee_demographics;
*/

# If you want to alias the case statement you do so on the END section, also considered a column so comma


-- SUBQUERIES
# a query inside another query
/*
SELECT *
FROM employee_demographics
WHERE employee_id IN 
		(SELECT employee_id
			FROM employee_salary
            WHERE dept_id = 1);
*/

# This is an example of a subquery being used for cross referencing

/*
SELECT first_name, salary, 
(SELECT AVG(salary)
FROM employee_salary) AS Average_sal
FROM employee_salary;
*/

# This is a subquery being used to give an aggregated column


SELECT gender, AVG(age),MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;


SELECT AVG(maxAge) AS avgMaxAge,
AVG(minAge) AS avgMinAge,
AVG(countAge)
FROM 
(SELECT gender, AVG(age) AS avgAge,
MAX(age) AS maxAge,
MIN(age) AS minAge,
COUNT(age) AS countAge
FROM employee_demographics
GROUP BY gender) AS AggTable
;


# This is a way to do complex aggreates, basically aggregating already aggregated functions

-- Window Functions

# Allow you to look at a group but they keep their own rows
# Similar to a GROUP BY

SELECT gender, AVG(salary) AS Avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;


# ^^ This is how you would group the avg salary by gender using group by

SELECT dem.first_name,
dem.last_name,
dem.age,
gender,
salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


# OVER() tells the table that it wants to do this over every thing

# OVER(PARTITION BY column name) tells the table what it wants to base it off of

# GROUP BY makes it distinct
# WINDOW lets them keep their rows if you want to have more data visible


SELECT dem.employee_id,
dem.first_name,
dem.last_name,
gender,
salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

#ROW_NUMBER() gives a row number to every value (resets for each partition)
#ROW_NUMBER() wont give the same row number to anything in the same partition

#RANK() is similar to row number however it will give the same rank to similar values (based on order by)
#RANK() gives number positionally (if there are 2 5's it will go to 7 instead of six)

#DENSE_RANK() is the same as rank but it gives it numerically (after 2 5s the next number will be a 6)

-- COMMON TABLE EXPRESSIONS
# kinda similar to making a function in python
# you can only use them exactly after you make them
# using a query to make a cte

# WITH name_of_function => the formula to name a CTE

WITH CTE_EXAMPLE (GENDER, AVG_SAL, MAX_SAL, MIN_SAL, COUNT_SAL) AS
(
SELECT gender, AVG(salary), MAX(salary), MIN(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_EXAMPLE;

# CTE generally used for higher readability and more advanced queries.
# You CAN still do this with subqueries tho

-- Temporary Tables
# TEMP TABLES ONLY EXIST FOR AS LONG AS YOU ARE IN THE SESSION
#its a temp table idk how to explain it


CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;


INSERT INTO temp_table
VALUES('Shiraz', 'Amiri', 'How to train your dragon')
;

SELECT * 
FROM employee_salary;

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

-- STORED PROCEDURES
# A way to save sql code to reuse over and over again
# might be an actual function
# a delimeter is something that seperates queries from one another (; is a delimeter)
DELIMITER $$ -- changing the 'end query' symbol so you can run multiple queries
-- ^^ use this when you have multiple lines of code so you can run them all together
-- DROP PROCEDURE if exists 'large_salaries()' => if you want to change/update the procedure
CREATE PROCEDURE large_salaries2()
BEGIN -- signifies the start of the stored procedure
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000; -- not telling the stop of the entire procedure just that query
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$ -- using the new delimiter stops the entire procedure
DELIMITER ; -- MAKE SURE YOU CHANGE IT BACK OTHERWISE IT WILL NOT ACT NORMALLY

call large_salaries2();
# Using an input to affect the response


DELIMITER $$
DROP PROCEDURE IF EXISTS `with_inputs`;
CREATE PROCEDURE with_inputs(input_id INT)
-- the two above functions drops the original table if it exists and replaces it with the one underneath
-- if you want an input for the case statement you have to declare it and its variable type
-- much like python :D
BEGIN
	SELECT *
    FROM employee_salary
    WHERE employee_id = input_id
    ;
END $$

DELIMITER ;

CALL with_inputs(1);

-- Triggers and Events

# TRIGGER: an block of code that 'triggers' when a certain event happens on a specific table
# ^^ its literally a trigger, kinda like scratch broadcast blocks

# EVENT is something that happens to a specific table

# EXAMPLE
DELIMITER $$ 
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary -- after is used because we are using this as a trigger
    FOR EACH ROW -- trigger is active for each row added, 4 new rows means 4 new triggers
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)-- you have to specify what data you want to insert
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name); -- use the NEW function to specify only the new data
    
    
END $$
DELIMITER ;
/*
EXPLANATION OF THE QUERY
DELIMITER $$ => this is changing the end query function to be $$ so you can run multiple functions
CREATE TRIGGER employee_insert => this is just naming the trigger
	AFTER INSERT ON employee_salary => this is the actual trigger itself
		^^ After a new insert on the table employee salary do the rest of the stuff
	FOR EACH ROW => this means that this trigger is active for each row and will trigger every time this happens
BEGIN => beginning of what you want it to do.. duh
	INSERT INTO employee_demographics (employee_id, first_name, last_name) => insert these columns from salary to demographics
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name) => only apply the new values added, not every single value 
    
END $$ => end of what you want it to do, using the delimiter we called earlier because it wont work otherwise
DELIMITER ; => make sure to change it back otherwise ur manager/other coders will kill you type shift
*/
-- AFTER is used if you want it to trigger when you add something
-- BEFORE is used when you want it to trigger when you remove something
-- NEW is when you only care about the new data being added 
-- OLD is when you care about the old data previously added

-- In order to find the trigger go 
-- 	DATABASE > TABLES > NAME OF TABLE TRIGGER IS FOR > TRIGGERS > NAME OF TRIGGER
-- ^ deadass useless cause you cant change anything about it

INSERT INTO employee_salary (employee_id,
first_name,
last_name,
occupation,
salary,
dept_id
)
VALUES (
12,
'Alex',
'Alakay',
'KING OF NEW YORK',
10000000,
NULL
);
-- This is to test out the trigger, by adding a new row to the salary table, it then adds the 3 columns 
-- to the demographics table
SELECT *
FROM employee_salary;

-- EVENTS
# TRIGGER happens when a event takes place
# EVENT is something that is scheduled
# very helpful for automation

SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
	DELETE 
    FROM employee_demographics
    WHERE age >= 60;
    
END $$
DELIMITER ;

/*
EXPLAINING THE EXAMPLE
DELIMITER $$ => you know what this does
CREATE EVENT delete_retirees => creates and names the event
ON SCHEDULE EVERY 30 SECOND => on is required, explains when it wants to trigger the event
^^  for time in this language, you can write: SECOND, MINUTE, MONTH, YEAR, etc
DO => what you want the event to do
BEGIN => begin the block of code it is going to run
	DELETE 
    FROM employee_demographics
    WHERE age >= 60;
    ^^ just deletes anyone thats too old
END $$ => bro it literally ends the block of code
DELIMITER ; => NEVER FORGET 
*/

SHOW VARIABLES LIKE 'event%'; -- this is to make sure your scheduler is on (sometimes it can be off
-- you can update it to make sure it is on

-- THIS IS THE END OF THE BIBLE, WE WILL ADD MORE AS IT COMES BUT CONGRATS!!!!!!!!!!!
