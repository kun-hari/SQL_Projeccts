Library Management System

Problem statement:
Design and implement a relational database to manage a library’s core operations—branches, staff, members, books, and circulation—supporting day-to-day CRUD tasks, summary reporting, and analytical queries for oversight and decision-making.

What was done:

Database design and setup:

•	Modeled a library schema with tables for branches, employees, members, books, issued status, and return status, including primary keys and foreign key relationships.
•	Established a clear entity structure to track holdings, membership, staffing, and circulation events.

Core operations (CRUD):

•	Created sample records for books and maintained member, employee, and circulation data.
•	Performed updates to member addresses and managed deletions in circulation logs where needed.
•	Retrieved operational views such as books issued by a specific employee.

Analytical and reporting workflows:

•	Built summary outputs, including issue counts per book and revenue-oriented category summaries.
•	Identified members with higher activity (e.g., more than one issue).
•	Produced cohort-style listings such as members registered in the last 180 days.
•	Joined employee and branch data to present staffing context alongside branch details.
•	Generated lists of currently unreturned (open) issues for follow-up.

CTAS artifacts:

•	Created derived tables for quick reference and reporting (e.g., per-book issue counts, expensive book sets).

Key objectives achieved:

•	End-to-end SQL workflow demonstrating schema design, relationship constraints, and integrity.
•	Practical CRUD interactions aligned to real-world library tasks.
•	Reusable analytical queries for circulation monitoring, category performance, staffing context, and member recency.
•	Creation of summary tables to support faster reporting and downstream analysis.

Results and insights:

•	Operational readiness: A normalized library_db schema that captures branches, staff, members, inventory, and circulation, enabling consistent day-to-day data management.
•	Circulation visibility: Clear tracking of issued vs. returned items and identification of outstanding loans.
•	Category performance: Aggregated views highlight rental value by category and books with higher issue frequency.
•	Member insights: Recent registrants and frequent issuers can be targeted for engagement or policy tuning.
•	Reporting foundation: CTAS outputs provide quick-access tables for dashboards or additional analysis.

Repository contents:
•	Project overview and objectives
•	Schema description and relationships
•	CRUD task outcomes and operational views
•	Analytical findings and summary table descriptions