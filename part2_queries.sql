-- 1. Show the possible values of the year column in the country_stats table sorted by most recent year first
SELECT DISTINCT year
FROM country_stats
ORDER BY year DESC;

-- 2. Show the names of the first 5 countries in the database when sorted in alphabetical order by name
SELECT name
FROM countries
ORDER BY name LIMIT 5;

-- 3. Adjust the previous query to show both the country name and the gdp from 2018, but this time show the top 5 countries by gdp.
SELECT name, gdp
FROM countries, country_stats 
WHERE countries.country_id = country_stats.country_id AND country_stats.year = 2018
ORDER BY gdp DESC LIMIT 5;

-- 4. How many countries are associated with each region id?
SELECT region_id, COUNT(region_id) AS country_count
FROM countries
GROUP BY region_id
ORDER BY country_count DESC;

-- 5. What is the average area of countries in each region id?
SELECT region_id, ROUND(SUM(area)/COUNT(region_id),0) AS avg_area
FROM countries
GROUP BY region_id
ORDER BY avg_area;

-- 6. Use the same query as above, but only show the groups with an average country area less than 1000
SELECT region_id, ROUND(SUM(area)/COUNT(region_id),0) AS avg_area
FROM countries
GROUP BY region_id HAVING ROUND(SUM(area)/COUNT(region_id),0) < 1000
ORDER BY avg_area;

-- 7. Create a report displaying the name and population of every continent in the database from the year 2018 in millions.
SELECT conts.name, ROUND(CAST(SUM(cs.population) AS NUMERIC(15, 0)) /1000000, 2) AS tot_pop 
FROM continents as conts 
LEFT OUTER JOIN regions ON regions.continent_id = conts.continent_id 
LEFT OUTER JOIN countries ON countries.region_id = regions.region_id
LEFT OUTER JOIN country_stats AS cs ON cs.country_id = countries.country_id
WHERE cs.year = 2018
GROUP BY conts.name
ORDER BY tot_pop DESC;

-- 8. List the names of all of the countries that do not have a language.
SELECT DISTINCT name
FROM countries 
WHERE country_id NOT IN (SELECT country_id FROM country_languages) 
ORDER BY name;

-- 9. Show the country name and number of associated languages of the top 10 countries with most languages
SELECT a.name, b.lang_count
FROM countries AS a 
INNER JOIN (SELECT country_id, COUNT(language_id) as lang_count
FROM country_languages
GROUP BY country_id) AS b ON a.country_id = b.country_id
ORDER BY b.lang_count DESC LIMIT 10;

-- 10. Repeat your previous query, but display a comma separated list of spoken languages rather than a count (use the aggregate function for strings, string_agg.

SELECT d.name, string_agg(d.language,',')
FROM (SELECT c.name,a.language
FROM languages AS a INNER JOIN country_languages AS b ON a.language_id = b.language_id
INNER JOIN countries AS c ON b.country_id = c.country_id) AS d
GROUP BY d.name
ORDER BY COUNT(d.language) DESC LIMIT 10;

-- 11. What's the average number of languages in every country in a region in the dataset? 
SELECT d.name, ROUND(SUM(d.lang_count)/COUNT(d.lang_count),1) AS avg_lang_count_per_country
FROM (SELECT c.name as name, a.name as reg, b.lang_count
FROM countries AS a 
INNER JOIN (SELECT country_id, COUNT(language_id) as lang_count
FROM country_languages
GROUP BY country_id) AS b ON a.country_id = b.country_id
INNER JOIN regions AS c ON a.region_id = c.region_id) AS d
GROUP BY d.name
ORDER BY avg_lang_count_per_country DESC;

-- 12. Show the country name and its "national day" for the country with the most recent national day and the country with the oldest national day. 

select b.name, a.min as national_day from countries as b, (select min(national_day) from countries) as a where a.min = b.national_day
union
select c.name, d.max as national_day from countries as c, (select max(national_day) from countries) as d where d.max = c.national_day;
