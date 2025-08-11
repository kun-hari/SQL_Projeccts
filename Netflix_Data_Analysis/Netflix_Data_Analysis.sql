create database netflix_shows;

SHOW VARIABLES LIKE 'secure_file_priv';

drop table if exists netflix;

create table netflix
(
	show_id	varchar(10),
	show_type varchar(10),	
	title varchar(150),	
	director varchar(255),	
	cast text,	
	country varchar(150),	
	date_added varchar(50),	
	release_year int,	
	rating varchar(10),	
	duration varchar(20),	
	listed_in varchar(255),	
	description text
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_titles.csv' -- (Importing data from CSV file)
INTO TABLE netflix
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(show_id, show_type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description);

select * from netflix;

select count(*) as total_content from netflix;

-- Netflix Data Analysis 
-- 1. Count the number of Movies vs TV Shows

SELECT 
	show_type,
	COUNT(*)
FROM netflix
GROUP BY 1;

-- 2. Find the most common rating for movies and TV shows

WITH RatingCounts AS (
SELECT
show_type,
rating,
COUNT(*) AS rating_count
FROM netflix
GROUP BY show_type, rating
),
RankedRatings AS (
SELECT
show_type,
rating,
rating_count,
RANK() OVER (PARTITION BY show_type ORDER BY rating_count DESC) AS rnk
FROM RatingCounts
)
SELECT
show_type,
rating AS most_frequent_rating
FROM RankedRatings
WHERE rnk = 1;

-- 3. List all movies released in a specific year (e.g., 2020)

SELECT * 
FROM netflix
WHERE release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix

SELECT * 
FROM
(
	SELECT 
		-- country,
		UNNEST(STRING_TO_ARRAY(country, ',')) as country,
		COUNT(*) as total_content
	FROM netflix
	GROUP BY 1
)as t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5;


-- 5. Identify the longest movie

SELECT
show_type,
title,
CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS minutes
FROM netflix
WHERE show_type = 'Movie' -- or WHERE type = 'Movie' if your column is named type
AND duration IS NOT NULL
ORDER BY minutes DESC
LIMIT 1;

-- 6. Find content added in the last 5 years
SELECT *
FROM netflix
WHERE STR_TO_DATE(date_added, '%M %e, %Y') >= CURRENT_DATE - INTERVAL 5 YEAR;


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT *
FROM
(

SELECT 
	*,
	UNNEST(STRING_TO_ARRAY(director, ',')) as director_name
FROM 
netflix
)
WHERE 
	director_name = 'Rajiv Chilaka';



-- 8. List all TV shows with more than 5 seasons

SELECT *
FROM netflix
WHERE show_type = 'TV Show'
AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;


-- 9. Count the number of content items in each genre

SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(*) as total_content
FROM netflix
GROUP BY 1;


-- 10. Find each year and the average numbers of content release by India on netflix. 
-- return top 5 year with highest avg content release !


SELECT
country,
release_year,
COUNT(show_id) AS total_release,
ROUND(
COUNT(show_id) / (
SELECT COUNT(show_id) FROM netflix WHERE country = 'India'
) * 100, 2
) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC
LIMIT 5;


-- 11. List all movies that are documentaries
SELECT * FROM netflix
WHERE listed_in LIKE '%Documentaries';



-- 12. Find all content without a director
SELECT * FROM netflix
WHERE director IS NULL;


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT * FROM netflix
WHERE 
	cast LIKE '%Salman Khan%'
	AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;


-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.



SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actor,
	COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

/*
Question 15:
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/


SELECT 
    category,
	show_TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2;


