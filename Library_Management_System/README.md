# **Library Management System**

## *Problem Statement*
Design and implement a relational database to manage a library’s core operations: branches, staff, members, books and circulation, supporting day-to-day CRUD tasks, summary reporting and analytical queries for oversight and decision-making.

## *Data Used*
**Branches**: Branch ID, name, location, and other branch-specific details.

**Employees**: Employee ID, name, role, associated branch ID, and contact information.

**Members**: Member ID, name, address, registration details, and status.

**Books**: Book ID, title, author, category, price, and inventory details.

**Circulation**: Records of books issued and returned, including issue dates, return dates, status, and associated member and employee IDs.

## *Methodology*
- Designed a normalized relational schema capturing the core entities of the library and their relationships.

- Created tables with appropriate primary keys and foreign key constraints to maintain data integrity and relational dependencies.

- Populated sample data for key entities including books, members, employees, and circulation events for testing and validation.

- Implemented CRUD operations to support day-to-day library tasks: adding/removing/updating members, books, staff, and managing circulation logs.

- Developed analytical SQL queries for operational reporting such as issue counts per book, member activity tracking, and staffing overview by branch.

- Created summary tables (CTAS) for quick reference in reporting workflows to improve performance and ease of analysis.

## *Observations and Results*
- Established a robust schema that supports consistent management of library branches, staff, members, and book inventory.

- Enabled effective tracking of book circulation including loans, returns, and overdue items, providing operational visibility.

- Generated insightful reports highlighting book popularity and category-wise rental revenue for strategic decision-making.

- Identified high-activity members and recent registrants for targeted outreach and program development.

- Integrated staffing and branch data for comprehensive views of human resource allocation.

- Built reusable analytical queries and summary tables that facilitate efficient reporting and monitoring of library operations.
