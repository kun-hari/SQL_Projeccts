-- Library system management

create database library_management;

-- Creating branch table

drop table if exists branch;
create table branch
(
branch_id varchar(10) primary key,	
manager_id	varchar (10),
branch_address	varchar (55),
contact_no varchar(10)
);

alter table branch
modify column contact_no varchar(20);

-- Creating employees table

drop table if exists employees;
create table employees
( 
emp_id varchar(10) primary key, 	
emp_name varchar (10),	
position varchar(10),	
salary int,
branch_id varchar(10),
FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

alter table employees
modify column emp_name varchar(20),
modify column salary int;

-- Creating books table

drop table if exists books;
create table books
(
isbn varchar(20) primary key,	
book_title varchar(100),	
category varchar(20),	
rental_price float,	
status varchar(10),	
author varchar(30),	
publisher varchar(30)
);

-- Creating members table

drop table if exists members;
create table members
(
member_id varchar(10) primary key,
member_name	varchar(20),
member_address varchar(50),	
reg_date date
);

-- Creating issue status table

drop table if exists issued_status;
create table issued_status
(
issued_id varchar(10) primary key,	
issued_member_id varchar(10),	
issued_book_name varchar(75),	
issued_date date,	
issued_book_isbn varchar(25),	
issued_emp_id varchar(10),
FOREIGN KEY (issued_member_id) REFERENCES members(member_id),

FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn)
);

-- Create return_status table

drop table if exists return_status;
create table return_status
(
return_id varchar(10) primary key,	
issued_id varchar(10),	
return_book_name varchar(75),	
return_date date,	
return_book_isbn varchar(20),
FOREIGN KEY (return_book_isbn) REFERENCES books(isbn),
FOREIGN KEY (issued_id) REFERENCES  issued_status(issued_id)
);

-- Adding data to the tables

select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;

-- CRUD operations

-- Task 1: Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';

-- Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE   issued_id =   'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT
    issued_emp_id,
    COUNT(*)
FROM issued_status
GROUP BY 1
HAVING COUNT(*) > 1;

-- CTAS operations

-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count
FROM issued_status as ist
JOIN books as b
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

-- Data analysis operations

-- Task 7: Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = 'Classic';

-- Task 8: Find Total Rental Income by Category:

SELECT 
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM 
issued_status as ist
JOIN
books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY 1;

-- Task 9: List Members Who Registered in the Last 180 Days:

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL 180 DAY;

-- Task 10: List Employees with Their Branch Manager's Name and their branch details:
SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.position,
    e1.salary,
    b.*,
    e2.emp_name as manager
FROM employees as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employees as e2
ON e2.emp_id = b.manager_id;

-- Task 11: Create a Table of Books with Rental Price Above a Certain Threshold:

CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;

-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT * FROM issued_status as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;