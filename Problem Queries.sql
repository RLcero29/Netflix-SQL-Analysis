-- Count the number of movies and TV shows in the table
SELECT type, COUNT(*)
FROM netflix
GROUP BY type


-- Find the most common ratings for movies and TV shows
SELECT type, rating, COUNT(*)
FROM Netflix
GROUP BY type, rating
ORDER BY COUNT(*) DESC


-- Find all movies released in a specific year (2000)
SELECT *
FROM netflix
WHERE type = 'Movie' AND release_year = '2000'


-- Find top 5 countries with most content on Netflix
SELECT UNNEST(STRING_TO_ARRAY(country, ',')) country, COUNT(show_id) country_content
FROM netflix
GROUP BY country
ORDER BY country_content DESC
LIMIT 5


-- Find content added in the last 5 years
SELECT type, title, release_year, date_added
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'


-- List all TV shows with more than 9 seasons
SELECT *
FROM netflix
WHERE type = 'TV Show' and CAST(SPLIT_PART(duration, ' ', 1) AS INT) > 9


-- Count total number of TV Shows/Movies in each genre
SELECT UNNEST(STRING_TO_ARRAY(listed_in, ',')) genre, count(show_id)
FROM netflix
GROUP BY genre
ORDER BY count(show_id) DESC


-- List all movies that are comedies
SELECT *
FROM netflix
WHERE listed_in ILIKE '%comedy%' and type = 'Movie'


-- Find all content without a director
SELECT *
FROM netflix
WHERE director IS NULL


-- Label content as bad content if description contains keywords "kill" or "violence" and label all others as good content
WITH new_table
AS (
SELECT *,
CASE
	WHEN description ILIKE '%kill%' or description ILIKE '%violence%' THEN 'Bad Content'
	ELSE 'Good Content'
	END labeled
FROM netflix
)
SELECT labeled, COUNT(labeled)
FROM new_table
GROUP BY labeled