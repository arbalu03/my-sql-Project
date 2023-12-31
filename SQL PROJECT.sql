CREATE DATABASE LIBRARY;
USE LIBRARY;
CREATE TABLE BRANCH (
BRANCH_NO INT PRIMARY KEY, 
MANAGER_ID INT, 
BRANCH_ADDRESS VARCHAR(30), 
CONTACT_NO INT);

INSERT INTO BRANCH (BRANCH_NO, MANAGER_ID, BRANCH_ADDRESS, CONTACT_NO) VALUES
(01,001,"IT", 986523583),
(02,002,"HR", 982258633),
(03,003,"ACCOUNTS",95225521),
(04,004,"ADM",982522582),
(05,006,"DEVP",986325523);

CREATE TABLE EMPLOYEE (
EMP_ID INT PRIMARY KEY,
EMP_NAME VARCHAR(30),
POSITION VARCHAR(30),
SALARY INT(10));

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, POSITION, SALARY) VALUES
(001,"JOHN","MANAGER", 100000),
(002,"RIYA","ASST MANAGER", 96000),
(003,"VIJAY","ACCOUNT HEAD", 98000),
(004,"RIYA", "HEAD CLK", 92000),
(005,"VEENA", "SENIOR DEVP",95000);

SELECT *FROM EMPLOYEE;


CREATE TABLE CUSTOMER (
CUSTOMER_ID INT PRIMARY KEY,
CUSTOMER_NAME VARCHAR(30), 
CUSTOMER_ADDRESS VARCHAR(50),
REG_DATE DATETIME);

INSERT INTO CUSTOMER( CUSTOMER_ID, CUSTOMER_NAME, CUSTOMER_ADDRESS, REG_DATE) VALUES
(11,"VINU", "TRIVANDRUM", CURDATE()),
(12,"RIYAS","KOCHI", curdate()),
(13,"NIMISHA","TRIVANDRUM", curdate()),
(14,"SAJAN", "KOLLAM", curdate()),
(15,"VINAY","KOCHI", curdate());

CREATE TABLE BOOKS (ISBN INT PRIMARY KEY ,
BOOK_TITLE VARCHAR(30),
CATEGORY VARCHAR(20),
RENTAL_PRICE INT(15),
STATAS VARCHAR(10),
AUTHOR VARCHAR(30),
PUBLISHER VARCHAR(30));

INSERT INTO BOOKS (ISBN, BOOK_TITLE, CATEGORY, RENTAL_PRICE, STATAS, AUTHOR, PUBLISHER) VALUES
(101,"GOD OF SMALL THINGS" ,"FICTION", 50, "YES", "ARUNDHATHI ROY", "J&K"),
(102, "WHITE TIGER", "FICTION",40, "NO", "ARAVID ADIGA", "SISO"),
(103, "NOTE BOOK", "FICTION", 35, "YES", "NICHOLAS SPPRKS", "SISO"),
(104, "DIGITAL MINIMALISM","SELF HELP", 45,"YES", "NEW CAL PORT", "RD"),
(105, "IKIGAI", "SELF HELP", 45,"YES","FRANCES MIRALLES","RD");

INSERT INTO BOOKS VALUES (106, "3IDIOTS", "FICTION", 45,"YES","CHETAN BHAGAT","RD");



CREATE TABLE ISSUESTATUS(ISSUE_ID INT PRIMARY KEY,
 ISSUED_CUST INT,
 ISSUED_BOOK_NAME VARCHAR(30),
 ISSUE_DATE DATETIME,
 ISBN_BOOK INT,
 FOREIGN KEY (ISSUED_CUST) REFERENCES CUSTOMER (CUSTOMER_ID) ON DELETE CASCADE,
 FOREIGN KEY (ISBN_BOOK) REFERENCES BOOKS (ISBN) ON DELETE CASCADE);
 
 INSERT INTO ISSUESTATUS (ISSUE_ID, ISSUED_CUST, ISSUED_BOOK_NAME, ISSUE_DATE, ISBN_BOOK) VALUES
 (001,11, "WHITE TIGER", SYSDATE(), 102),
 (002,13, "IKIGAI", SYSDATE(), 105),
 (003,15, "NOTE BOOK", SYSDATE(), 103),
 (004,12, "GOD OF SMALL THINGS", SYSDATE(), 101),
 (005, 14, "DIGITAL MINIMALISM",SYSDATE(), 104);
 
 CREATE TABLE RETURN_STATUS ( RETURN_ID INT PRIMARY KEY,
 RETURN_CUST INT,
 RETURN_BOOK_NAME VARCHAR(30),
 RETURN_DATE DATETIME,
 ISBN_BOOK2 INT,
 FOREIGN KEY (ISBN_BOOK2) REFERENCES BOOKS(ISBN) ON DELETE CASCADE);
 
 
 INSERT INTO RETURN_STATUS ( RETURN_ID, RETURN_CUST, RETURN_BOOK_NAME, RETURN_DATE, ISBN_BOOK2) VALUES
(011,11, "WHITE TIGER", SYSDATE(), 102),
 (012,13, "IKIGAI", SYSDATE(), 105),
 (013,15, "NOTE BOOK", SYSDATE(), 103),
 (014,12, "GOD OF SMALL THINGS", SYSDATE(), 101),
 (015, 14, "DIGITAL MINIMALISM",SYSDATE(), 104);
 
 
 -- Q1. Retrieve the book title, category, and rental price of all available books.
 
 SELECT BOOK_TITLE, CATEGORY, RENTAL_PRICE FROM BOOKS  WHERE STATAS = "YES";
 
 -- Q2. List the employee names and their respective salaries in descending order of salary
 
 SELECT EMP_NAME, SALARY FROM EMPLOYEE ORDER BY  SALARY DESC;
 
 -- Q3. Retrieve the book titles and the corresponding customers who have issued those books.
 
 SELECT *FROM ISSUESTATUS;
 SELECT *FROM CUSTOMER;
 SELECT * FROM BOOKS;
 
 
 SELECT B.BOOK_TITLE, C.CUSTOMER_NAME
FROM BOOKS B
JOIN ISSUESTATUS I ON B.ISBN = I.ISBN_BOOK
JOIN CUSTOMER C ON I.ISSUED_CUST = C.CUSTOMER_ID;

  
 -- Q4. Display the total count of books in each category.
 
 SELECT CATEGORY, COUNT(*) AS TOTAL_COUNT FROM BOOKS GROUP BY CATEGORY;


 -- Q5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.95000.
 
 SELECT EMP_NAME, POSITION FROM EMPLOYEE WHERE SALARY >95000;

--  Q6. List the customer names who registered before 2022-01-01 and have not issued any books yet

SELECT *FROM CUSTOMER;
SELECT *FROM ISSUESTATUS;
INSERT INTO CUSTOMER VALUES (16,"MITHAL", "KOLLAM", sysdate());
DELETE FROM ISSUESTATUS WHERE ISSUE_ID =6;

 
SELECT CUSTOMER_ID,CUSTOMER_NAME FROM CUSTOMER WHERE REG_DATE > "2023-06-11" AND CUSTOMER_ID 
NOT IN (SELECT ISSUED_CUST FROM ISSUESTATUS);

  
-- Q7.  Display the branch numbers and the total count of employees in each branch.

SELECT * FROM BRANCH;
SELECT * FROM EMPLOYEE;
SELECT BRANCH_NO, COUNT(*) AS TOTAL_COUNT
FROM BRANCH
GROUP BY BRANCH_NO;




-- Q8.  Display the names of customers who have issued books in the month of June 2023. 
SELECT *FROM CUSTOMER;
SELECT *FROM ISSUESTATUS;
UPDATE ISSUESTATUS SET ISSUE_DATE ='2023-05-12' WHERE ISSUE_ID = 1 ;

SELECT CUSTOMER_NAME,CUSTOMER_ID FROM CUSTOMER WHERE CUSTOMER_ID IN (SELECT ISSUED_CUST FROM ISSUESTATUS
WHERE ISSUE_DATE >= '2023-06-01' AND ISSUE_DATE < '2023-07-01'); 

-- Q9.  Retrieve book_title from book table containing FICTION. 

SELECT *FROM BOOKS;

SELECT BOOK_TITLE FROM BOOKS WHERE CATEGORY = 'FICTION';

-- Q10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees



SELECT *FROM BRANCH;
SELECT *FROM EMPLOYEE;
UPDATE BRANCH SET MANAGER_ID =5 WHERE BRANCH_NO =5;

SELECT B.BRANCH_NO, COUNT(*) AS TOTAL_COUNT
FROM EMPLOYEE E
JOIN BRANCH B ON E.EMP_ID = B.MANAGER_ID
GROUP BY B.BRANCH_NO
HAVING COUNT(*) > 0;

