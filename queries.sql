-- *** 1. BASIC UNDERSTANDING ***
-- A. How many total records and unique members are in the dataset?

SELECT COUNT(*) AS total_records, 
		COUNT(DISTINCT bioname) AS unique_members
FROM congress;

-- B. What is the earliest and latest congress session in the data?
SELECT MIN(start_date) AS first_congress,
		MAX(start_date) AS last_congress
FROM congress;

-- C. How many memebrs served in the House vs Senate?
SELECT chamber, COUNT(DISTINCT bioname) AS member_count
FROM congress
GROUP BY chamber;

-- D. How many states are represented?
SELECT COUNT(DISTINCT state_abbrev) AS total_states
FROM congress;

-- E. How many unique parties are there?
SELECT COUNT(DISTINCT party_code) AS total_parties
FROM congress;

-- *** 2. AGE & GENERAIONAL INSIGHTS ***

-- A. Average age by congress
SELECT congress, ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
FROM congress
GROUP BY congress
ORDER BY congress;

-- B. Which congress was younges and oldest
SELECT ROUND(MAX(age_years)::NUMERIC, 2) AS oldest, ROUND(MIN(age_years)::NUMERIC, 2) AS youngest
FROM congress;

-- C. Average age difference between House and Senate
SELECT chamber, ROUND(AVG(age_years)::NUMERIC, 2)
FROM congress
GROUP BY 1;

-- D. Dominant generation in each congress
SELECT congress, generation, COUNT(*) AS members
FROM congress
GROUP BY 1, 2
ORDER BY 1, 2 DESC;

-- E. How many generation changed over time
SELECT congress, generation, COUNT(*) AS count
FROM congress
GROUP BY 1, 2
ORDER BY 1, 2;

-- *** 3. STATE-LEVEL ANALYSIS ***

-- A. Top 5 states with most members
SELECT state_abbrev, COUNT(DISTINCT bioname) total_members
FROM congress
GROUP BY state_abbrev
ORDER BY total_members DESC
LIMIT 5;

-- B. States with oldest average members
SELECT state_abbrev, ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
FROM congress
GROUP BY state_abbrev
ORDER BY avg_age DESC
LIMIT 5;

-- C. States with youngest average members
SELECT state_abbrev, ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
FROM congress
GROUP BY state_abbrev
ORDER BY avg_age ASC
LIMIT 5;

-- D. States age increase over time 
SELECT state_abbrev, congress, ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
FROM congress
GROUP BY state_abbrev, congress
ORDER BY state_Abbrev, congress;

-- *** 4. PARTY AND CHAMBER COMPARISONS *** 

-- A. Average age per political party
SELECT party_code, ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
FROM congress
GROUP BY party_code
ORDER BY avg_Age DESC;

-- B. Oldest party members on average

SELECT party_code, ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
FROM congress
GROUP BY party_code
ORDER BY avg_Age DESC
LIMIT 1;

-- C. Senate vs House age comparison
SELECT chamber, ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
FROM congress
GROUP BY chamber;

-- D. Average age trend by party over time
SELECT congress, party_code, ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
FROM congress
GROUP BY congress, party_code
ORDER BY congress, party_code;

-- E. Generational distribution by party
SELECT party_code, generation, COUNT(*) total
FROM congress
GROUP BY party_code, generation
ORDER BY party_code, total DESC;

-- *** 5. CAREER & TENURE ANALYSIS ***

-- A. Top 10 longest-serving members
SELECT bioname, COUNT(DISTINCT congress) AS total_congresses
FROM congress
GROUP BY bioname
ORDER BY total_congresses desc
LIMIT 10

-- B. Average number of sessions per member
SELECT ROUND(AVG(total_sessions)) avg_sessions
FROM (
	SELECT bioname, COUNT(DISTINCT congress) AS total_sessions
	FROM congress
	GROUP BY bioname
	) AS sub;

-- C. Longest-serving generation
SELECT generation, ROUND(AVG(total_sessions)::NUMERIC, 2) AS avg_sessions
FROM (
	SELECT generation, bioname, COUNT(DISTINCT congress) AS total_sessions
	FROM congress
	GROUP BY generation, bioname
) AS sub
GROUP BY generation, total_sessions
ORDER BY avg_sessions DESC;
;

-- D. Average starting age of members

SELECT ROUND(AVG(starting_age)::NUMERIC, 2) AS avg_starting_age
FROM (
	SELECT ROUND((start_date - birthday)/ 365.25, 2) AS starting_age
	FROM congress
	 )

-- *** 6. TIME TRENDS ***

-- A. Average age per decade
SELECT ROUND((EXTRACT(YEAR FROM start_date)/10)*10) AS decade,
		ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
FROM congress
GROUP BY decade
ORDER BY decade
;

-- B. When Boomers overtook Silent generaion
SELECT congress, generation, COUNT(*) AS count
FROM congress
WHERE generation IN ('Boomer', 'Silent')
GROUP BY congress, generation
ORDER BY congress
;

-- C. Age distribution by Congress
SELECT congress,
		ROUND(MIN(age_years)::NUMERIC, 2) AS youngest,
		ROUND(MAX(age_years)::NUMERIC, 2) AS oldest,
		ROUND(AVG(age_years)::NUMERIC, 2) as avg_age
FROM congress
GROUP BY congress
ORDER BY congress
;

-- D. Median or central trend (approximate)
SELECT congress,
		ROUND(percentile_cont(0.5) WITHIN GROUP (ORDER BY age_years)::NUMERIC, 2) AS median_Age
FROM congress
GROUP BY congress
ORDER BY congress
;

-- E. House vs Senate age gap trend
SELECT ROUND(
			AVG(CASE WHEN chamber = 'Senate' THEN age_years END)::NUMERIC
			-
			AVG(CASE WHEN chamber = 'House' THEN age_years END)::NUMERIC, 2
			) AS age_gap
FROM congress;

-- *** 7. ADVANCED STORYTELLING ***

-- A. Youngest member ever
SELECT bioname, age_years, congress
FROM congress
ORDER BY age_years ASC
LIMIT 1;

-- B. Oldest Member ever
SELECT bioname, age_years, congress
FROM congress
ORDER BY age_years DESC
LIMIT 1;

-- C. Most common egenration overall
SELECT generation, COUNT(*) AS total
FROM congress
GROUP BY generation
ORDER BY total DESC
LIMIT 1;

-- D. Decade with biggest average age jump
SELECT decade, avg_age,
		LAG(avg_age) OVER(ORDER BY decade) AS prev_year_age,
		(avg_age - LAG(avg_age) OVER(ORDER BY decade)) AS increase
FROM (
	SELECT 
		ROUND((EXTRACT(YEAR FROM start_date)/10)*10) AS decade,
		ROUND(AVG(age_years)::NUMERIC, 2) AS avg_age
	FROM congress
	GROUP BY decade
	 ) AS sub
ORDER BY increase DESC

-- E. average career length (First to last congresss)
SELECT ROUND(AVG(last_congress - first_congress), 2) avg_career_length
FROM (
	SELECT bioname,
	     MIN(congress) AS first_congress,
		 MAX(congress) AS last_congress
	FROM congress
	GROUP BY bioname
	) AS sub
