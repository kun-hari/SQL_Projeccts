Netflix Data Analysis

Summary:
This project builds a MySQL-based analytics workflow over the public Netflix titles dataset. It covers schema design, bulk CSV ingest, data cleaning considerations, and a suite of exploratory queries to answer common content insights.

What it does:

Creates a database (netflix_shows) and a normalized-ish table (netflix) to store show metadata, including show type, title, director, cast, country, release year, rating, duration, genres (listed_in), and description.

Loads data from a CSV via LOAD DATA INFILE (compatible with MySQL’s secure_file_priv setting).

Runs a curated set of SQL analyses to explore catalog composition and trends.

Key analyses included:

Movies vs TV Shows count

Aggregates content by show_type to understand catalog mix.

Most common rating per show type

Uses window functions to rank ratings and pick the most frequent rating for Movies and TV Shows.

Movies released in a given year

Parameterizable filter (example: 2020) to list all titles released that year.

Top 5 countries by content volume

Splits multi-country rows to properly attribute counts per country and ranks the top contributors.

Longest movie

Parses the duration field to identify the single longest movie by minutes.

Content added in the last 5 years

Converts textual date_added to date and filters by a rolling 5-year window.

Titles by a specific director (example: Rajiv Chilaka)

Splits multi-director fields and filters for an exact match.

TV shows with more than 5 seasons

Parses duration for TV seasons and filters for long-running series.

Content count by genre

Splits listed_in (multi-genre field) and aggregates to show genre popularity.

India’s yearly release share (Top 5 years)

Computes each year’s share of India-produced titles relative to India’s total, returns top 5 years.

All documentary movies

Filters titles tagged as Documentaries.

Content without a director

Identifies incomplete or missing director metadata.

Salman Khan movies in the last 10 years

Filters cast and recent release_years to count appearances.

Top 10 Indian actors by appearances

Splits casts and ranks actors by count among India-produced titles.

Content safety categorization

Labels titles as “Bad” if description contains “kill” or “violence,” otherwise “Good,” and counts by category and show_type.

Notes and considerations:

The script uses MySQL-specific functions (e.g., STR_TO_DATE, SUBSTRING_INDEX, window functions). The splitting of comma-separated fields is demonstrated using UNNEST/STRING_TO_ARRAY, which are PostgreSQL patterns—swap in a MySQL-compatible splitter (e.g., JSON-based splitter, recursive CTE, or a numbers helper table) when running on MySQL.

Ensure secure_file_priv allows CSV import path for LOAD DATA INFILE.

Some text fields (date_added, duration, country, director, cast, listed_in) may need cleaning and trimming; whitespace handling is recommended after splitting.

The schema keeps raw text fields to remain faithful to the CSV; for production, consider normalizing many-to-many fields (countries, directors, cast, genres).

Deliverables:

DDL to create the database and table

CSV load command

A collection of analysis queries answering common content questions

How to run:

Set secure_file_priv and place the CSV accordingly.

Execute the DDL and LOAD DATA INFILE statements.

Run the analysis queries section by section.

If using MySQL, replace any non-MySQL splitting functions with MySQL-compatible approaches.