# Netflix Data Analytics: Exploratory Study of Public Streaming Data

## *Summary*
This project implements a MySQL-driven analytics workflow on the public Netflix titles dataset. It covers database schema creation, secure bulk data loading and a comprehensive set of SQL queries to uncover insights on content distribution, popularity, and trends. The analysis addresses multiple facets such as content types, ratings, release patterns and regional productions.

## *Problem Statement*
To design and deploy a MySQL database solution that supports efficient ingestion, cleaning and exploratory analysis of Netflix show metadata, enabling data-driven decision-making on content composition, user interest and catalog performance. The goal is to provide actionable insights on streaming content dynamics to inform content curation and market-focused strategies.

## *Data Used*
**Netflix Shows Dataset**:
 Contains metadata for titles including show type (Movie or TV Show), title, director(s), cast members, country of origin, release year, rating, duration, genres (listed_in), description, date added, and other relevant fields.


## *Methodology*
- Created a dedicated database schema (netflix_shows) with a normalized-ish table (netflix) to capture show metadata in structured format.

- Imported data from a CSV file using MySQL’s LOAD DATA INFILE functionality, while ensuring secure file privileges were correctly configured.

- Applied data cleaning considerations for multi-valued fields such as genres, cast, directors, and countries to enable accurate analysis, recommending trimming and whitespace handling post-splitting.

- Employed a suite of exploratory SQL queries leveraging MySQL-specific functions, including window functions and string manipulation, to analyze the dataset across multiple dimensions.

- Suggested adapting splitting techniques for multi-valued fields using JSON functions or recursive CTEs in MySQL given some example queries are based on PostgreSQL syntax.

## *Observations and Results*
- Quantified mix of content types, distinguishing counts of movies versus TV shows to understand catalog composition.

- Determined the most common rating per show type using ranking analytics for enhanced content classification.

- Extracted and listed movies released in specific years for targeted temporal analyses.

- Identified top contributing countries by content volume with normalized attribution for multi-country productions.

- Calculated the longest movie based on parsed duration fields.

- Provided recent content additions leveraging date filters over the past five years to gauge catalog updates.

- Filtered shows by director and cast to surface insights on notable contributors such as Rajiv Chilaka and Salman Khan.

- Analyzed long-running TV shows exceeding five seasons to identify established series.

- Computed genre popularity by splitting multi-genre fields.

- Assessed India’s yearly production share, highlighting top years of content output globally.

- Isolated documentary movies and assessed metadata completeness by finding entries without directors.

- Categorized content safety based on thematic keywords in descriptions, labeling titles as “Bad” or “Good.”

- Ranked top Indian actors by appearance count within India-produced titles.
