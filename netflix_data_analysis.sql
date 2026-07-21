-- Netflix Project

Create Table netflix(
	show_id varchar(10),
	type varchar(10),
	title varchar(200),
	director varchar(250),
	casts varchar(1000),
	country varchar(150),
	date_added varchar(50),
	release_year int,
	rating varchar(10),
	duration varchar(15),
	listed_in varchar(100),
	description varchar(300)
);

select count(*) from netflix;

select * from netflix
limit 10;

-- Count all the null Values

SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE director IS NULL) AS director_null,
    COUNT(*) FILTER (WHERE casts IS NULL) AS casts_null,
    COUNT(*) FILTER (WHERE country IS NULL) AS country_null,
    COUNT(*) FILTER (WHERE date_added IS NULL) AS date_added_null,
    COUNT(*) FILTER (WHERE rating IS NULL) AS rating_null,
    COUNT(*) FILTER (WHERE duration IS NULL) AS duration_null
FROM netflix;


---  Fixing THE NULL VALUE IN director COLUMN ========
select director
from netflix;

update netflix
set director = 'Not Specified'
where director is null;

SELECT COUNT(*) FILTER (WHERE director IS NULL) AS remaining_nulls
FROM netflix;


SELECT show_id, title, director 
FROM netflix 
WHERE director = 'Not Specified' 
LIMIT 10;

---  Fixing THE NULL VALUE IN casts COLUMN ========

UPDATE netflix
SET casts = 'Not Specified'
WHERE casts IS NULL;

---  Fixing THE NULL VALUE IN country COLUMN ========

UPDATE netflix
SET country = 'Not Specified'
WHERE country IS NULL;


SELECT show_id, title, type, date_added
FROM netflix
WHERE date_added IS NULL;


UPDATE netflix
SET rating = 'Not Rated'
WHERE rating IS NULL;


SELECT DISTINCT rating FROM netflix ORDER BY rating;

-- Convert date_added to Proper DATE Type ===============

ALTER TABLE netflix ADD COLUMN date_added_clean DATE;

UPDATE netflix
SET date_added_clean = TO_DATE(TRIM(date_added), 'Month DD, YYYY')
WHERE date_added IS NOT NULL;

-- Split duration into Numeric Columns ==========

ALTER TABLE netflix ADD COLUMN duration_minutes INT;
ALTER TABLE netflix ADD COLUMN seasons INT;

UPDATE netflix
SET duration_minutes = CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INT)
WHERE type = 'Movie' AND duration IS NOT NULL;

UPDATE netflix
SET seasons = CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INT)
WHERE type = 'TV Show' AND duration IS NOT NULL;

SELECT type, duration, duration_minutes, seasons
FROM netflix
LIMIT 10;

-- (1). Question: What is the distribution of Movies and TV Shows on Netflix?
--
-- This query calculates the total number of titles for each content type
-- (Movie or TV Show) and determines the percentage of each type relative
-- to the total number of titles in the Netflix dataset.


SELECT 
    type,
    COUNT(*) AS total_titles,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix), 2) AS percentage
FROM netflix
GROUP BY type;

-- Question: 2) What is the distribution of Netflix titles by rating?
--
-- This query analyzes the distribution of Netflix content across different
-- age ratings. It calculates the total number of titles and the percentage
-- of the overall Netflix catalog for each rating. The results are sorted
-- in descending order to identify the most common content ratings first.

SELECT 
    rating,
    COUNT(*) AS total_titles,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix), 2) AS percentage
FROM netflix
GROUP BY rating
ORDER BY total_titles DESC;


-- Question:- 3)  What are the top 10 countries producing the most Netflix titles?
--
-- This query identifies the top 10 countries with the highest number
-- of Netflix titles. It excludes records where the country is not specified,
-- groups the data by country, and sorts the results in descending order
-- based on the total number of titles.

SELECT 
    country,
    COUNT(*) AS total_titles
FROM netflix
WHERE country != 'Not Specified'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;


-- Question:- 4) Who are the top 10 directors with the most titles on Netflix?
--
-- This query identifies the top 10 directors who have the highest number
-- of titles in the Netflix dataset. It excludes records where the director
-- is not specified, groups the data by director, and sorts the results
-- in descending order based on the total number of titles directed.

SELECT 
    director,
    COUNT(*) AS total_titles
FROM netflix
WHERE director != 'Not Specified'
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;


-- Question:- 5) How many Netflix titles were added in each year?
--
-- This query analyzes the yearly trend of titles added to Netflix.
-- It extracts the year from the cleaned date-added column, counts
-- the number of titles added in each year, excludes records with
-- missing dates, and sorts the results chronologically.

SELECT 
    EXTRACT(YEAR FROM date_added_clean) AS year_added,
    COUNT(*) AS titles_added
FROM netflix
WHERE date_added_clean IS NOT NULL
GROUP BY year_added
ORDER BY year_added;


-- Question: 6) What are the oldest and newest release years for Movies and TV Shows on Netflix?
--
-- This query analyzes the release year range of Netflix content by type.
-- It identifies the earliest and latest release years for Movies and TV Shows
-- separately using the MIN() and MAX() aggregate functions.

SELECT 
    type,
    MIN(release_year) AS oldest_release,
    MAX(release_year) AS newest_release
FROM netflix
GROUP BY type;

-- Question:-7) How many Netflix titles were released in each decade?
--
-- This query analyzes the distribution of Netflix titles across different
-- decades based on their release years. It groups the release years into
-- 10-year periods, counts the total number of titles in each decade,
-- and sorts the results chronologically.

SELECT 
    (release_year / 10) * 10 AS decade,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY decade
ORDER BY decade;


-- Question:-8) What is the average duration of Netflix Movies by release year?
--
-- This query analyzes the average duration of Netflix Movies for each
-- release year. It filters the dataset to include only Movies with
-- available duration values, calculates the average duration in minutes
-- for each release year, rounds the result to one decimal place,
-- and sorts the results chronologically.

SELECT 
    release_year,
    ROUND(AVG(duration_minutes), 1) AS avg_duration
FROM netflix
WHERE type = 'Movie' 
  AND duration_minutes IS NOT NULL
GROUP BY release_year
ORDER BY release_year;


-- Question:-9) What are the top 10 most common genres on Netflix?
--
-- This query identifies the top 10 most common genres in the Netflix dataset.
-- Since a single title can belong to multiple genres, the `listed_in` column
-- is split into individual genres using STRING_TO_ARRAY() and UNNEST().
-- Extra spaces are removed using TRIM(), and the genres are counted and
-- sorted in descending order to find the most frequently occurring genres.

SELECT 
    TRIM(genre) AS genre,
    COUNT(*) AS total_titles
FROM netflix, 
     LATERAL UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
GROUP BY TRIM(genre)
ORDER BY total_titles DESC
LIMIT 10;


-- Question:-10) What is the average number of genres per Netflix title?
--
-- This query calculates the average number of genres associated with each
-- Netflix title. It first counts the number of genres listed for every title
-- by splitting the comma-separated `listed_in` values into an array.
-- It then calculates the average genre count across all titles and rounds
-- the result to two decimal places.

SELECT 
    ROUND(AVG(genre_count), 2) AS avg_genres_per_title
FROM (
    SELECT 
        show_id, 
        ARRAY_LENGTH(STRING_TO_ARRAY(listed_in, ','), 1) AS genre_count
    FROM netflix
) sub;


-- Question:-11) Which Netflix titles had the longest gap between their release year
-- and the year they were added to Netflix?
--
-- This query identifies the top 10 Netflix titles with the largest time gap
-- between their original release year and the year they were added to Netflix.
-- It extracts the year from the date-added column, calculates the difference
-- between the year added and the original release year, and sorts the results
-- in descending order to show the largest gaps first.

SELECT 
    show_id,
    title,
    release_year,
    EXTRACT(YEAR FROM date_added_clean) AS year_added,
    EXTRACT(YEAR FROM date_added_clean) - release_year AS gap_years
FROM netflix
WHERE date_added_clean IS NOT NULL
ORDER BY gap_years DESC
LIMIT 10;


-- Question:-12) Which countries have the highest number of Netflix Movies and TV Shows?
--
-- This query identifies the top 10 countries with the highest total number
-- of Netflix titles and breaks down the count into Movies and TV Shows.
-- It excludes records where the country is not specified, groups the data
-- by country, and uses conditional aggregation to separately count Movies
-- and TV Shows. The results are sorted by the combined total of Movies
-- and TV Shows in descending order.

SELECT 
    country,
    COUNT(*) FILTER (WHERE type = 'Movie') AS movies,
    COUNT(*) FILTER (WHERE type = 'TV Show') AS tv_shows
FROM netflix
WHERE country != 'Not Specified'
GROUP BY country
ORDER BY 
    COUNT(*) FILTER (WHERE type = 'Movie') 
    + COUNT(*) FILTER (WHERE type = 'TV Show') DESC
LIMIT 10;


-- Question:-13) What percentage of Netflix titles released each year are rated for mature audiences?
--
-- This query analyzes the proportion of mature-rated Netflix titles for each
-- release year. It counts titles with ratings such as TV-MA, R, and NC-17,
-- compares them with the total number of titles released in each year,
-- and calculates the percentage of mature content.

SELECT 
    release_year,
    COUNT(*) FILTER (
        WHERE rating IN ('TV-MA', 'R', 'NC-17')
    ) AS mature_titles,
    
    COUNT(*) AS total_titles,
    
    ROUND(
        COUNT(*) FILTER (
            WHERE rating IN ('TV-MA', 'R', 'NC-17')
        ) * 100.0 / COUNT(*),
        2
    ) AS mature_percentage

FROM netflix
GROUP BY release_year
ORDER BY release_year;



-- Question: Which TV Shows on Netflix have the most seasons?
--
-- This query identifies the top 10 TV Shows with the highest number
-- of seasons available on Netflix. It filters the dataset to include
-- only TV Shows with a specified number of seasons, sorts the results
-- in descending order based on the number of seasons, and returns
-- the top 10 shows along with their ratings and countries.

SELECT 
    title,
    seasons,
    rating,
    country
FROM netflix
WHERE type = 'TV Show' 
  AND seasons IS NOT NULL
ORDER BY seasons DESC
LIMIT 10;